import 'package:calmendar/main.dart';
import 'package:calmendar/src/controllers/calendar_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({super.key, required this.isVisible});

  final bool isVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarController);
    final firstDayOfMonth = ref
        .read(calendarController.notifier)
        .firstDayOfMonth(calendarState.selectedDate);

    final daysInMonth = ref
        .read(calendarController.notifier)
        .daysInMonth(calendarState.selectedDate);

    final prevMonthDays = ref.read(calendarController.notifier).daysInMonth(
        DateTime(calendarState.selectedDate.year,
            calendarState.selectedDate.month - 1));

    // Get weekday index (Monday = 1, Sunday = 7), convert to zero-based (0 = Monday, 6 = Sunday)
    int firstWeekday = (firstDayOfMonth.weekday % 7) - 1;

    // Total grid slots needed (empty slots before + days in month)
    int totalSlots = firstWeekday + daysInMonth;

    final weekdays = ref.read(calendarController.notifier).weekdays;

    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdays.map((day) {
            return Expanded(
              child: Text(
                day[0],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .outline, // Default color
                    ),
              ),
            );
          }).toList(),
        ),

        // Grid of days
        GridView.builder(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Disable scrolling
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 7 columns for each weekday
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount:
              totalSlots + (7 - (totalSlots % 7)), // Ensure full last row
          itemBuilder: (context, index) {
            if (index < firstWeekday) {
              // Previous month days
              int prevDay = prevMonthDays - (firstWeekday - index - 1);
              return DottedBorder(
                borderType: BorderType.Circle,
                color: Theme.of(context).colorScheme.outline,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    prevDay.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isVisible
                              ? Theme.of(context).colorScheme.outline
                              : Colors.transparent,
                        ),
                  ),
                ),
              );
            } else if (index < firstWeekday + daysInMonth) {
              int dayNumber = index - firstWeekday + 1;
              final date = DateTime(calendarState.selectedDate.year,
                  calendarState.selectedDate.month, dayNumber);
              bool isToday = date.isAtSameMomentAs(todayDateOnly);
              bool isPast = date.isBefore(todayDateOnly);
              bool isFuture = date.isAfter(todayDateOnly);

              return GestureDetector(
                onTap: () {
                  ref
                      .read(calendarController.notifier)
                      .updateSelectedDate(date);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isToday
                        ? seedColor
                        : isPast
                            ? Theme.of(context)
                                .colorScheme
                                .onSurface // Past dates in black
                            : isFuture
                                ? Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withValues(
                                        alpha: 0.5) // Future dates in gray
                                : Theme.of(context).colorScheme.onSurface,
                  ),
                  child: Text(
                    dayNumber.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isVisible
                              ? Theme.of(context).colorScheme.surface
                              : Colors.transparent,
                        ),
                  ),
                ),
              );
            } else {
              // Next month days
              int nextDay = index - (firstWeekday + daysInMonth) + 1;
              return DottedBorder(
                borderType: BorderType.Circle,
                color: Theme.of(context).colorScheme.outline,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    nextDay.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: isVisible? Theme.of(context).colorScheme.outline : Colors.transparent,
                        ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
