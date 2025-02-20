import 'package:calmendar/src/controllers/seed_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ColorSwitcherWidget extends ConsumerWidget {
  const ColorSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Color>(
      icon: const Icon(
        Icons.color_lens_outlined, // Use any icon you like here
      ),
      onSelected: (Color newColor) {
        ref.read(seedColorController.notifier).updateSeedColor(newColor);
      },
      initialValue: ref.watch(seedColorController),
      tooltip: "Change Color",
      constraints: BoxConstraints(maxHeight: 300),
      itemBuilder: (BuildContext context) {
        return colors.map((color) {
          return PopupMenuItem<Color>(
            value: color,
            child: Row(
              children: [
                Icon(Icons.circle, color: color),
                SizedBox(width: 8),
                Text(color.name, overflow: TextOverflow.ellipsis),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
