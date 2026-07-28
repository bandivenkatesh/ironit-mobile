/// Addresses Page
/// Page for managing user's saved addresses
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/empty_state_widget.dart';
import '../providers/profile_providers.dart';
import '../widgets/address_card.dart';

class AddressesPage extends ConsumerWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Map<String, dynamic>>> addressesAsync =
        ref.watch(addressBookProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: addressesAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Failed to load addresses',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (List<Map<String, dynamic>> addresses) {
          if (addresses.isEmpty) {
            return EmptyStateWidget(
              icon: const Icon(
                Icons.location_on,
                size: 64,
                color: Colors.grey,
              ),
              title: 'No Addresses Saved',
              subtitle: 'Add your first address to get started',
              action: ElevatedButton(
                onPressed: () {
                  // TODO: Implement add address
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add address feature coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: const Text('Add Address'),
              ),
            );
          }

          return _buildAddressesList(context, addresses);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add address
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Add address feature coming soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Addresses',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  /// Build the addresses list
  Widget _buildAddressesList(
      BuildContext context, List<Map<String, dynamic>> addresses) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.medium),
      itemCount: addresses.length,
      itemBuilder: (BuildContext context, int index) {
        final Map<String, dynamic> address = addresses[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.medium),
          child: AddressCard(
            address: address,
            onEdit: () {
              // TODO: Implement edit address
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Edit address feature coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            onDelete: () {
              // TODO: Implement delete address
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Delete address feature coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            onSetDefault: address['isDefault']
                ? null
                : () {
                    // TODO: Implement set default address
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Set default feature coming soon!'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
          ),
        );
      },
    );
  }
}