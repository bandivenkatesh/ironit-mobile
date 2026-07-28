/// Notes Field Widget
/// Reusable component for adding special instructions
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/booking_providers.dart';

class NotesField extends ConsumerWidget {
  const NotesField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String notes = ref.watch(notesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Special Instructions (Optional)',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        TextField(
          decoration: InputDecoration(
            hintText: 'Add any special instructions for the professional...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.medium),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.medium),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.medium),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.medium),
          ),
          maxLines: 4,
          onChanged: (String value) {
            ref.read(notesProvider.notifier).state = value;
          },
          controller: TextEditingController(text: notes),
          style: AppTypography.bodyText1,
        ),
      ],
    );
  }
}
