
import 'package:calmendar/src/controllers/calendar_controller.dart';
import 'package:calmendar/src/controllers/seed_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentMonthWidget extends ConsumerStatefulWidget {
  const CurrentMonthWidget({
    super.key,
    required this.date,
    required this.isToday,
    required this.isPast,
    required this.isFuture,
    required this.dayNumber,
    required this.isVisible,
  });

  final DateTime date;
  final bool isToday;
  final bool isPast;
  final bool isFuture;
  final int dayNumber;
  final bool isVisible;

  @override
  ConsumerState<CurrentMonthWidget> createState() => _CurrentMonthWidgetState();
}

class _CurrentMonthWidgetState extends ConsumerState<CurrentMonthWidget> {
  bool _isHovering = false;
  
  @override
  Widget build(BuildContext context) {
    final seedColor = ref.watch(seedColorController);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
      child: GestureDetector(
        onTap: () {
          ref.read(calendarController.notifier).updateSelectedDate(widget.date);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isToday
                ? seedColor
                : widget.isPast
                    ? Theme.of(context)
                        .colorScheme
                        .onSurface // Past dates in black
                    : widget.isFuture
                        ? Theme.of(context)
                            .colorScheme
                            .outline
                            .withValues(alpha: 0.5) // Future dates in gray
                        : Theme.of(context).colorScheme.onSurface,
          ),
          child: Text(
            widget.dayNumber.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: widget.isVisible
                      ? Theme.of(context).colorScheme.surface
                      : Colors.transparent,
                ),
          ),
        )
            .animate(
              target: _isHovering ? 1 : 0,
            )
            .tint(
              end: 0.5,
              color: Theme.of(context).colorScheme.outlineVariant,
            )
            .scaleXY(begin: 1, end: 1.1, curve: Curves.easeInOutCubic),
      ),
    );
  }
}
