/// Home Dashboard Page
/// Main dashboard after authentication with service discovery and browsing
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ironit/features/home/domain/models/category.dart';
import 'package:ironit/features/home/domain/models/promotion.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import '../../domain/models/service.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Build the app bar with search functionality
  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        'Ironit Dashboard',
        style: AppTypography.subtitle1.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {
            // TODO: Implement notifications
          },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            // TODO: Navigate to profile
          },
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
              hintText: 'Search services...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                          _searchController.clear();
                        });
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
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
      ),
    );
  }

  /// Build the main body content based on current tab
  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeDashboard();
      case 1:
        return _buildServicesScreen();
      case 2:
        return _buildBookingsScreen();
      case 3:
        return _buildProfileScreen();
      default:
        return _buildHomeDashboard();
    }
  }

  /// Build the home dashboard with all sections
  Widget _buildHomeDashboard() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Greeting Section
          _buildGreetingSection(),
          const SizedBox(height: AppSpacing.small),

          // Promotions Carousel
          _buildPromotionsCarousel(),
          const SizedBox(height: AppSpacing.medium),

          // Featured Services
          _buildFeaturedServicesSection(),
          const SizedBox(height: AppSpacing.medium),

          // Categories
          _buildCategoriesSection(),
          const SizedBox(height: AppSpacing.medium),

          // Popular Services
          _buildPopularServicesSection(),
          const SizedBox(height: AppSpacing.medium),

          // Recently Viewed
          _buildRecentlyViewedSection(),
          const SizedBox(height: AppSpacing.large),
        ],
      ),
    );
  }

  /// Build greeting section with user info
  Widget _buildGreetingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome back,',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xSmall),
          Text(
            'User!',
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Row(
            children: <Widget>[
              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 16,
              ),
              const SizedBox(width: AppSpacing.xSmall),
              Text(
                'Hyderabad, India',
                style: AppTypography.bodyText2.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build promotions carousel
  Widget _buildPromotionsCarousel() {
    final AsyncValue<List<Promotion>> promotionsAsync =
        ref.watch(activePromotionsProvider);

    return promotionsAsync.when(
      loading: () => const LoadingWidget(),
      error: (Object error, StackTrace stack) => ErrorStateWidget(
        message: error.toString(),
        onRetry: () => ref.refresh(activePromotionsProvider),
      ),
      data: (List<Promotion> promotions) {
        if (promotions.isEmpty) {
          return const SizedBox(height: 160);
        }

        return SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: promotions.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? AppSpacing.medium : AppSpacing.small,
                  right: index == promotions.length - 1 ? AppSpacing.medium : 0,
                ),
                child: PromotionBanner(
                  promotion: promotions[index],
                  onAction: () {
                    // TODO: Handle promotion action
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Build featured services section
  Widget _buildFeaturedServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Text(
            'Featured Services',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        _buildServicesList(ref.watch(featuredServicesProvider)),
      ],
    );
  }

  /// Build categories section
  Widget _buildCategoriesSection() {
    final AsyncValue<List<Category>> categoriesAsync =
        ref.watch(allCategoriesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Browse Categories',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: View all categories
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        categoriesAsync.when(
          loading: () => const LoadingWidget(),
          error: (Object error, StackTrace stack) => ErrorStateWidget(
            message: error.toString(),
            onRetry: () => ref.refresh(allCategoriesProvider),
          ),
          data: (List<Category> categories) {
            if (categories.isEmpty) {
              return EmptyStateWidget(
                icon: const Icon(Icons.category),
                title: 'No Categories',
                subtitle: 'No service categories available',
                action: ElevatedButton(
                  onPressed: () => ref.refresh(allCategoriesProvider),
                  child: const Text('Refresh'),
                ),
              );
            }

            return SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? AppSpacing.medium : AppSpacing.small,
                      right: index == categories.length - 1
                          ? AppSpacing.medium
                          : 0,
                    ),
                    child: CategoryCard(
                      category: categories[index],
                      onTap: () {
                        // TODO: Navigate to category detail
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  /// Build popular services section
  Widget _buildPopularServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Text(
            'Popular Services',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        _buildServicesList(ref.watch(popularServicesProvider)),
      ],
    );
  }

  /// Build recently viewed section
  Widget _buildRecentlyViewedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Recently Viewed',
                style: AppTypography.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // TODO: View all recently viewed
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        _buildServicesList(ref.watch(allServicesProvider)),
      ],
    );
  }

  /// Build services list with search functionality
  Widget _buildServicesList(AsyncValue<List<Service>> servicesAsync) {
    return servicesAsync.when(
      loading: () => const LoadingWidget(),
      error: (Object error, StackTrace stack) => ErrorStateWidget(
        message: error.toString(),
        onRetry: () => ref.refresh(allServicesProvider),
      ),
      data: (List<Service> services) {
        final List<Service> filteredServices = _searchQuery.isEmpty
            ? services
            : services.where((Service service) {
                return service.name
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ||
                    service.description
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase());
              }).toList();

        if (filteredServices.isEmpty) {
          return EmptyStateWidget(
            icon: const Icon(Icons.search_off),
            title: 'No Services Found',
            subtitle: _searchQuery.isEmpty
                ? 'No services available'
                : 'No services match your search',
            action: _searchQuery.isEmpty
                ? null
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _searchQuery = '';
                        _searchController.clear();
                      });
                    },
                    child: const Text('Clear Search'),
                  ),
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            mainAxisSpacing: AppSpacing.small,
            crossAxisSpacing: AppSpacing.small,
          ),
          itemCount: filteredServices.length,
          itemBuilder: (BuildContext context, int index) {
            return ServiceCard(
              service: filteredServices[index],
              onTap: () {
                // TODO: Navigate to service detail
              },
              isCompact: true,
            );
          },
        );
      },
    );
  }

  /// Build services screen
  Widget _buildServicesScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.build,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Services Screen',
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Browse all available services',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Build bookings screen
  Widget _buildBookingsScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.calendar_today,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Bookings Screen',
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'View and manage your bookings',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Build profile screen
  Widget _buildProfileScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.person,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            'Profile Screen',
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          Text(
            'Manage your account and preferences',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// Build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
