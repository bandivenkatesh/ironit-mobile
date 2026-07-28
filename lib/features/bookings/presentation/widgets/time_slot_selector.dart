/// Time Slot Selector Widget
/// Reusable component for selecting booking time slot
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../providers/booking_providers.dart';
import '../../domain/models/time_slot.dart';

class TimeSlotSelector extends ConsumerWidget {
  const TimeSlotSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<TimeSlot>> timeSlotsAsync =
        ref.watch(availableTimeSlotsProvider);
    final TimeSlot? selectedTimeSlot = ref.watch(selectedTimeSlotProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Select Time Slot',
          style: AppTypography.headline6.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.small),
        timeSlotsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace stack) => Center(
            child: Text(
              'Failed to load time slots',
              style: AppTypography.bodyText2.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
          data: (List<TimeSlot> timeSlots) {
            if (timeSlots.isEmpty) {
              return Center(
                child: Text(
                  'No available time slots',
                  style: AppTypography.bodyText1.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }

            return SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: timeSlots.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: AppSpacing.small),
                itemBuilder: (BuildContext context, int index) {
                  final TimeSlot timeSlot = timeSlots[index];
                  final bool isSelected = selectedTimeSlot?.id == timeSlot.id;

                  return TimeSlotChip(
                    timeSlot: timeSlot,
                    isSelected: isSelected,
                    onSelected: () {
                      ref.read(selectedTimeSlotProvider.notifier).state =
                          timeSlot;
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Individual time slot chip widget
class TimeSlotChip extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool isSelected;
  final VoidCallback onSelected;

  const TimeSlotChip({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(AppSpacing.small),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppSpacing.medium),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outlineVariant,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              timeSlot.formattedTime,
              style: AppTypography.bodyText1.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? Theme.of(context).colorScheme.onPrimary
                    : Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xSmall),
            if (!timeSlot.isAvailable)
              Text(
                'Not Available',
                style: AppTypography.bodyText2.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
