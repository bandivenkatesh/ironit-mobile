/// Address Selector Widget
/// Reusable component for selecting delivery address
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/booking_providers.dart';
import '../../domain/models/address.dart';

class AddressSelector extends ConsumerWidget {
  const AddressSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Address>> addressesAsync =
        ref.watch(userAddressesProvider);
    final Address? selectedAddress = ref.watch(selectedAddressProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Select Delivery Address',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        addressesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stack) => Center(
            child: Text(
              'Failed to load addresses',
              style: AppTypography.bodyText2.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          data: (List<Address> addresses) {
            if (addresses.isEmpty) {
              return Center(
                child: Text(
                  'No addresses found',
                  style: AppTypography.bodyText1.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }

            return Column(
              children: <Widget>[
                ...addresses.map((Address address) {
                  final bool isSelected = selectedAddress?.id == address.id;

                  return AddressCard(
                    address: address,
                    isSelected: isSelected,
                    onSelected: () {
                      ref.read(selectedAddressProvider.notifier).state =
                          address;
                    },
                  );
                }).toList(),
                const SizedBox(height: AppSpacing.small),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement add new address flow
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Add new address feature coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add New Address'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSpacing.small),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Individual address card widget
class AddressCard extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onSelected;

  const AddressCard({
    super.key,
    required this.address,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.small),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outlineVariant,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onSelected,
        borderRadius: BorderRadius.circular(AppSpacing.medium),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: Row(
            children: <Widget>[
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              if (isSelected) const SizedBox(width: AppSpacing.small),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          address.label,
                          style: AppTypography.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (address.isDefault)
                          Container(
                            margin:
                                const EdgeInsets.only(left: AppSpacing.xSmall),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xSmall,
                              vertical: AppSpacing.xxSmall,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.xSmall),
                            ),
                            child: Text(
                              'DEFAULT',
                              style: AppTypography.bodyText2.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xSmall),
                    Text(
                      address.formattedAddress,
                      style: AppTypography.bodyText2.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                onPressed: () {
                  // TODO: Implement edit address flow
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Edit address feature coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
