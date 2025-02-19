import 'package:calmendar/src/controllers/calendar_controller.dart';
import 'package:calmendar/src/views/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  bool isVisible = true;
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarController);

    final Size size = MediaQuery.of(context).size;
    final dateHeight = size.height * 0.15;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Large text for the date

                const Spacer(),

                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovering = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovering = false;
                    });
                  },
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
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
                    )
                        .animate(
                          target: _isHovering ? 1 : 0,
                        )
                        .tint(
                          end: 0.5,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        )
                        .scaleXY(
                            begin: 1, end: 1.01, curve: Curves.easeInOutCubic),
                  ),
                ),

                SizedBox(height: 16),
                // Row for the month & day name
                Row(
                  children: <Widget>[
                    // Month
                    Text(
                      calendarState.month.toUpperCase(),
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                fontSize: dateHeight * 0.25,
                                fontWeight: FontWeight.bold,
                              ),
                    ),

                    // Spacer
                    const Spacer(),

                    // Day name
                    Text(
                      calendarState.dayName,
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
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
                        ref
                            .read(calendarController.notifier)
                            .updateSelectedMonth(
                                calendarState.selectedDate, -1);
                      },
                    ),

                    // Right arrow
                    IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        ref
                            .read(calendarController.notifier)
                            .updateSelectedMonth(calendarState.selectedDate, 1);
                      },
                    ),

                    // Spacer
                    const Spacer(),

                    // Eye button
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(isVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined)),
                  ],
                ),

                SizedBox(height: 16),

                // Calendar

                CalendarWidget(
                  isVisible: isVisible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
