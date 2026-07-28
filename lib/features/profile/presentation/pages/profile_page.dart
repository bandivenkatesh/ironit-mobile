/// Profile Page
/// Main user profile screen with account information and navigation
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_menu_tile.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Map<String, dynamic>> profileAsync =
        ref.watch(profileDataProvider);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: profileAsync.when(
        loading: () => const LoadingWidget(),
        error: (Object error, StackTrace stack) => Center(
          child: Text(
            'Failed to load profile',
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (Map<String, dynamic> profile) {
          return _buildProfileContent(context, profile);
        },
      ),
    );
  }

  /// Build the app bar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'My Profile',
        style: AppTypography.headline6.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  /// Build the profile content
  Widget _buildProfileContent(
      BuildContext context, Map<String, dynamic> profile) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Profile header
          _buildProfileHeader(context, profile),
          const SizedBox(height: AppSpacing.medium),

          // Account section
          _buildAccountSection(context, profile),
          const SizedBox(height: AppSpacing.large),

          // Settings section
          _buildSettingsSection(context),
          const SizedBox(height: AppSpacing.large),

          // Support section
          _buildSupportSection(context),
          const SizedBox(height: AppSpacing.large),

          // Sign out button
          _buildSignOutButton(context),
          const SizedBox(height: AppSpacing.xLarge),
        ],
      ),
    );
  }

  /// Build profile header with avatar and user info
  Widget _buildProfileHeader(
      BuildContext context, Map<String, dynamic> profile) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.medium),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.surfaceContainer,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: <Widget>[
          // Avatar
          CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Text(
              (profile['name'] as String)[0].toUpperCase(),
              style: AppTypography.headline4.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.medium),

          // User name
          Text(
            profile['name'] as String,
            style: AppTypography.headline5.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.xSmall),

          // User email
          Text(
            profile['email'] as String,
            style: AppTypography.bodyText1.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.small),

          // User phone
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.phone,
                size: 16,
                color: Colors.grey,
              ),
              const SizedBox(width: AppSpacing.xSmall),
              Text(
                profile['phone'] as String,
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

  /// Build account section with user stats
  Widget _buildAccountSection(
      BuildContext context, Map<String, dynamic> profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'My Account',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),

          // Account stats
          Row(
            children: <Widget>[
              Expanded(
                child: _buildStatCard(
                  context,
                  'Bookings',
                  profile['stats']['bookings'].toString(),
                  Icons.history,
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Addresses',
                  profile['stats']['addresses'].toString(),
                  Icons.location_on,
                ),
              ),
              const SizedBox(width: AppSpacing.small),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Rewards',
                  profile['stats']['rewards'].toString(),
                  Icons.star,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.medium),

          // My Addresses navigation
          ProfileMenuTile(
            icon: Icons.location_on,
            title: 'My Addresses',
            subtitle: 'Manage saved delivery addresses',
            onTap: () {
              context.push('/addresses');
            },
          ),
        ],
      ),
    );
  }

  /// Build stat card for account section
  Widget _buildStatCard(
      BuildContext context, String label, String value, IconData icon) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.medium),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.small),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: AppSpacing.xSmall),
            Text(
              value,
              style: AppTypography.headline6.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.xxSmall),
            Text(
              label,
              style: AppTypography.bodyText2.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build settings section
  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Settings & Preferences',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),

          // Preferences navigation
          ProfileMenuTile(
            icon: Icons.settings,
            title: 'Preferences',
            subtitle: 'Notification, theme, and app settings',
            onTap: () {
              context.push('/preferences');
            },
          ),
        ],
      ),
    );
  }

  /// Build support section
  Widget _buildSupportSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Help & Support',
            style: AppTypography.headline6.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.medium),

          // Help & Support navigation
          ProfileMenuTile(
            icon: Icons.help_outline,
            title: 'Help Center',
            subtitle: 'FAQ and support resources',
            onTap: () {
              context.push('/help-support');
            },
          ),
          const SizedBox(height: AppSpacing.small),

          // About navigation
          ProfileMenuTile(
            icon: Icons.info_outline,
            title: 'About Ironit',
            subtitle: 'App information and version',
            onTap: () {
              context.push('/about');
            },
          ),
        ],
      ),
    );
  }

  /// Build sign out button
  Widget _buildSignOutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      child: OutlinedButton(
        onPressed: () {
          // TODO: Implement sign out functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign out feature coming soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.small),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        child: Text(
          'Sign Out',
          style: AppTypography.bodyText1.copyWith(
            color: Theme.of(context).colorScheme.error,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
