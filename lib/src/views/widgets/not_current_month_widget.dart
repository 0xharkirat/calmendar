import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NotCurrentMonthWidget extends StatefulWidget {
  const NotCurrentMonthWidget({
    super.key,
    required this.day,
    required this.isVisible,
    required this.onTap,
  });

  final int day;
  final bool isVisible;
  final VoidCallback onTap;

  @override
  State<NotCurrentMonthWidget> createState() => _NotCurrentMonthWidgetState();
}

class _NotCurrentMonthWidgetState extends State<NotCurrentMonthWidget> {
  bool _isHovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
        onTap: widget.onTap,
        child: DottedBorder(
          borderType: BorderType.Circle,
          color: Theme.of(context).colorScheme.outline,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.day.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: widget.isVisible
                        ? Theme.of(context).colorScheme.outline
                        : Colors.transparent,
                  ),
            ),
          )
        ).animate(
              target: _isHovering ? 1 : 0,
            )
            .tint(
              end: 0.5,
              color: Theme.of(context).colorScheme.onSurface,
            )
            .scaleXY(begin: 1, end: 1.1, curve: Curves.easeInOutCubic)
      ),
    );
  }
}
