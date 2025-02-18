import 'package:calmendar/src/controllers/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendarState = ref.watch(calendarController);

    final Size size = MediaQuery.of(context).size;
    final dateHeight = size.height * 0.15;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Large text for the date
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                ref
                    .read(calendarController.notifier)
                    .updateSelectedDate(DateTime.now());
              },
              child: Text(
                calendarState.selectedDate.day.toString(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: dateHeight,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            SizedBox(height: 16),
            // Row for the month & day name
            Row(
              children: <Widget>[
                // Month
                Text(
                  calendarState.month.toUpperCase(),
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: dateHeight * 0.25,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                // Spacer
                const Spacer(),

                // Day name
                Text(
                  calendarState.dayName,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: dateHeight * 0.25,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            // Year
            Text(
              calendarState.year.toString(),
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                    fontSize: dateHeight * 0.20,
                  ),
            ),

            SizedBox(height: 16),

            // Row for the controls
            Row(
              children: <Widget>[
                // Left arrow
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    ref.read(calendarController.notifier).updateSelectedDate(
                        calendarState.selectedDate
                            .subtract(const Duration(days: 1)));
                  },
                ),

                // Right arrow
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    ref.read(calendarController.notifier).updateSelectedDate(
                        calendarState.selectedDate
                            .add(const Duration(days: 1)));
                  },
                ),

                // Spacer
                const Spacer(),

                // Eye button
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye_outlined)),
              ],
            ),

            SizedBox(height: 16),

            // Calendar
            
          ],
        ),
      ),
    );
  }
}
