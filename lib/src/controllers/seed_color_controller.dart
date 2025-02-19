import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeedColorController extends Notifier<Color> {
  @override
  Color build() {
    return Colors.orange;
  }

  void updateSeedColor(Color newColor) {
    state = newColor;
  }
}

final seedColorController = NotifierProvider<SeedColorController, Color>(() {
  return SeedColorController();
});

const colors = [
  Colors.orange,
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.pink,
  Colors.teal,
  Colors.amber,
  Colors.cyan,
  Colors.indigo,
  Colors.lime,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.yellow,
];

// extension to get name of color
extension ColorName on Color {
  String get name {
    if (this == Colors.orange) {
      return 'Orange';
    } else if (this == Colors.red) {
      return 'Red';
    } else if (this == Colors.blue) {
      return 'Blue';
    } else if (this == Colors.green) {
      return 'Green';
    } else if (this == Colors.purple) {
      return 'Purple';
    } else if (this == Colors.pink) {
      return 'Pink';
    } else if (this == Colors.teal) {
      return 'Teal';
    } else if (this == Colors.amber) {
      return 'Amber';
    } else if (this == Colors.cyan) {
      return 'Cyan';
    } else if (this == Colors.indigo) {
      return 'Indigo';
    } else if (this == Colors.lime) {
      return 'Lime';
    } else if (this == Colors.deepOrange) {
      return 'Deep Orange';
    } else if (this == Colors.deepPurple) {
      return 'Deep Purple';
    } else if (this == Colors.lightBlue) {
      return 'Light Blue';
    } else if (this == Colors.lightGreen) {
      return 'Light Green';
    } else if (this == Colors.yellow) {
      return 'Yellow';
    } else {
      return 'Unknown';
    }
  }
}
