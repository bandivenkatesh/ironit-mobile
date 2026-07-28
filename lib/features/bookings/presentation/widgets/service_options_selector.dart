/// Service Options Selector Widget
/// Reusable component for selecting service customizations
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/booking_providers.dart';
import '../../domain/models/service_option.dart';

class ServiceOptionsSelector extends ConsumerWidget {
  const ServiceOptionsSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<ServiceOption>> optionsAsync =
        ref.watch(serviceOptionsProvider);
    final List<ServiceOption> selectedOptions =
        ref.watch(selectedOptionsProvider);
    final double totalPrice = ref.watch(totalPriceProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Customize Your Service',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        optionsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stack) => Center(
            child: Text(
              'Failed to load service options',
              style: AppTypography.bodyText2.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          data: (List<ServiceOption> options) {
            if (options.isEmpty) {
              return Center(
                child: Text(
                  'No customization options available',
                  style: AppTypography.bodyText1.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }

            return Column(
              children: <Widget>[
                ...options.map((ServiceOption option) {
                  final bool isSelected = selectedOptions.any(
                    (ServiceOption selected) => selected.id == option.id,
                  );

                  return ServiceOptionTile(
                    option: option,
                    isSelected: isSelected,
                    onSelected: (bool selected) {
                      final List<ServiceOption> updatedOptions =
                          List<ServiceOption>.from(selectedOptions);

                      if (selected) {
                        if (!updatedOptions
                            .any((ServiceOption opt) => opt.id == option.id)) {
                          updatedOptions.add(option);
                        }
                      } else {
                        updatedOptions.removeWhere(
                            (ServiceOption opt) => opt.id == option.id);
                      }

                      ref.read(selectedOptionsProvider.notifier).state =
                          updatedOptions;
                    },
                  );
                }).toList(),
                const SizedBox(height: AppSpacing.medium),
                _buildPriceSummary(context, ref, totalPrice),
              ],
            );
          },
        ),
      ],
    );
  }

  /// Build price summary section
  Widget _buildPriceSummary(
      BuildContext context, WidgetRef ref, double totalPrice) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Price Summary',
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            const Divider(),
            const SizedBox(height: AppSpacing.small),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total Price',
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${totalPrice.toStringAsFixed(2)}',
                  style: AppTypography.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual service option tile widget
class ServiceOptionTile extends StatelessWidget {
  final ServiceOption option;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const ServiceOptionTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: InkWell(
        onTap: () => onSelected(!isSelected),
        borderRadius: BorderRadius.circular(AppSpacing.medium),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: <Widget>[
              Checkbox(
                value: isSelected,
                onChanged: (bool? value) {
                  if (value != null) {
                    onSelected(value);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.xSmall),
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      option.name,
                      style: AppTypography.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (option.description.isNotEmpty) ...<Widget>[
                      const SizedBox(height: AppSpacing.xSmall),
                      Text(
                        option.description,
                        style: AppTypography.bodyText2.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (option.price > 0)
                Text(
                  '+ ₹${option.price.toStringAsFixed(2)}',
                  style: AppTypography.bodyText1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
