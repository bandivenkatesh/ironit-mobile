/// Services Page
/// Dedicated screen for browsing and filtering services by category
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../widgets/service_card.dart';
import '../providers/service_providers.dart';
import '../widgets/category_chip.dart';
import '../../../home/domain/models/service.dart';
import '../../../home/domain/models/category.dart';
import '../../../home/data/mock/categories.dart';

class ServicesPage extends ConsumerStatefulWidget {
  const ServicesPage({super.key});

  @override
  ConsumerState<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends ConsumerState<ServicesPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  /// Build the app bar with search functionality
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Browse Services',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.tune),
          onPressed: _showSortOptions,
          tooltip: 'Sort and Filter',
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.medium,
            vertical: AppSpacing.xSmall,
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search all services...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.large),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.small,
                vertical: AppSpacing.xSmall,
              ),
            ),
            onChanged: (String query) {
              ref.read(searchQueryProvider.notifier).state = query;
            },
          ),
        ),
      ),
    );
  }

  /// Show sort options bottom sheet
  void _showSortOptions() {
    showModalBottomSheet<Widget>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.large),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sort By',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.small),
              _buildSortOption('Default', 'default'),
              _buildSortOption('Price: Low to High', 'price-low-high'),
              _buildSortOption('Price: High to Low', 'price-high-low'),
              _buildSortOption('Rating: High to Low', 'rating'),
              _buildSortOption('Duration: Short to Long', 'duration'),
              const SizedBox(height: AppSpacing.small),
              Center(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build a sort option tile
  Widget _buildSortOption(String label, String value) {
    final String currentSort = ref.watch(sortOptionProvider);

    return ListTile(
      title: Text(label),
      trailing: currentSort == value
          ? Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: () {
        ref.read(sortOptionProvider.notifier).state = value;
        Navigator.pop(context);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.small),
      ),
    );
  }

  /// Build the main body with category chips and service grid
  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildCategoryChips(),
        const SizedBox(height: AppSpacing.small),
        Expanded(child: _buildServicesGrid()),
      ],
    );
  }

  /// Build category filter chips
  Widget _buildCategoryChips() {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
        children: <Widget>[
          CategoryChip(
            categoryId: 'all',
            label: 'All',
            isSelected: ref.watch(selectedCategoryProvider) == 'all',
            onSelected: () {
              ref.read(selectedCategoryProvider.notifier).state = 'all';
            },
          ),
          const SizedBox(width: AppSpacing.xSmall),
          ...MockCategories.getAllCategories().map((Category category) {
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.xSmall),
              child: CategoryChip(
                categoryId: category.id,
                label: category.name,
                isSelected: ref.watch(selectedCategoryProvider) == category.id,
                onSelected: () {
                  ref.read(selectedCategoryProvider.notifier).state =
                      category.id;
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  /// Build the services grid with proper state handling
  Widget _buildServicesGrid() {
    final AsyncValue<List<Service>> servicesAsync =
        ref.watch(filteredAndSortedServicesProvider);

    return servicesAsync.when(
      loading: () => const LoadingWidget(),
      error: (Object error, StackTrace stack) => ErrorStateWidget(
        message: error.toString(),
        onRetry: () => ref.refresh(filteredAndSortedServicesProvider),
      ),
      data: (List<Service> services) {
        if (services.isEmpty) {
          return EmptyStateWidget(
            icon: const Icon(Icons.search_off),
            title: 'No Services Found',
            subtitle: ref.watch(selectedCategoryProvider) == 'all'
                ? 'No services available'
                : 'No services in this category',
            action: ElevatedButton(
              onPressed: () {
                ref.read(selectedCategoryProvider.notifier).state = 'all';
                ref.read(searchQueryProvider.notifier).state = '';
              },
              child: const Text('View All'),
            ),
          );
        }

        return GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(AppSpacing.small),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: AppSpacing.small,
            crossAxisSpacing: AppSpacing.small,
          ),
          itemCount: services.length,
          itemBuilder: (BuildContext context, int index) {
            return ServiceCard(
              service: services[index],
              onTap: () {
                context.go('/service/${services[index].id}');
              },
              isCompact: true,
              showCategory: services[index].isFeatured,
            );
          },
        );
      },
    );
  }
}
