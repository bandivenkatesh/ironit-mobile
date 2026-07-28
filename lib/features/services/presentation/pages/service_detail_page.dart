/// Service Detail Page
/// Professional mock page showing detailed service information
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_state_widget.dart';
import '../providers/service_providers.dart';
import '../../../home/domain/models/service.dart';

class ServiceDetailPage extends ConsumerWidget {
  final String serviceId;

  const ServiceDetailPage({
    super.key,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Service?> serviceAsync =
        ref.watch(serviceByIdProvider(serviceId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Details'),
        centerTitle: true,
      ),
      body: serviceAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => ErrorStateWidget(
          message: error.toString(),
          onRetry: () => ref.refresh(serviceByIdProvider(serviceId)),
        ),
        data: (Service? service) {
          if (service == null) {
            return ErrorStateWidget(
              message: 'Service not found',
              onRetry: () => ref.refresh(serviceByIdProvider(serviceId)),
            );
          }

          return _buildServiceDetailContent(context, service);
        },
      ),
    );
  }

  /// Build the detailed service content
  Widget _buildServiceDetailContent(BuildContext context, Service service) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Service Image
          _buildServiceImage(context, service),
          const SizedBox(height: AppSpacing.medium),

          // Service Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title and Category
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        service.name,
                        style: AppTypography.headline5.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    Chip(
                      label: Text(
                        'Category',
                        style: AppTypography.bodyText2.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.small),

                // Rating and Reviews
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: AppSpacing.xSmall),
                    Text(
                      service.rating.toString(),
                      style: AppTypography.bodyText1.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xSmall),
                    Text(
                      '(${service.reviewCount} reviews)',
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.medium),

                // Price and Duration
                Row(
                  children: <Widget>[
                    Text(
                      '₹${service.price.toStringAsFixed(0)}',
                      style: AppTypography.headline6.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.small),
                    Icon(
                      Icons.timer_outlined,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.xSmall),
                    Text(
                      '${service.estimatedDuration.inMinutes} min',
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.large),

                // Description
                Text(
                  'Description',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                Text(
                  service.description,
                  style: AppTypography.bodyText1.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.large),

                // Key Features
                Text(
                  'Key Features',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                _buildFeatureItem(
                  context,
                  Icons.check_circle,
                  'Professional quality',
                ),
                _buildFeatureItem(
                  context,
                  Icons.timer,
                  'Quick turnaround time',
                ),
                _buildFeatureItem(context, Icons.eco, 'Eco-friendly processes'),
                _buildFeatureItem(
                  context,
                  Icons.local_laundry_service,
                  'Expert handling',
                ),
                const SizedBox(height: AppSpacing.large),

                // What's Included
                Text(
                  'What\'s Included',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.small),
                ..._buildIncludedItems(context),
                const SizedBox(height: AppSpacing.xLarge),

                // CTA Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/booking-entry', extra: service);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSpacing.small),
                      ),
                    ),
                    child: const Text('Book Now'),
                  ),
                ),
                const SizedBox(height: AppSpacing.large),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the service image section
  Widget _buildServiceImage(BuildContext context, Service service) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        image: service.imageUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(service.imageUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: service.imageUrl.isEmpty
          ? const Center(
              child: Icon(
                Icons.iron_outlined,
                size: 64,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }

  /// Build a feature item
  Widget _buildFeatureItem(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xSmall),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.small),
          Text(
            text,
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  /// Build included items list
  List<Widget> _buildIncludedItems(BuildContext context) {
    return <Widget>[
      _buildFeatureItem(context, Icons.check, 'Basic ironing service'),
      _buildFeatureItem(context, Icons.check, 'Quality control check'),
      _buildFeatureItem(context, Icons.check, 'Packaging and delivery'),
      _buildFeatureItem(context, Icons.check, 'Customer support'),
    ];
  }
}
