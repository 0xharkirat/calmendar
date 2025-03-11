import 'package:calmendar/src/controllers/seed_color_controller.dart';
import 'package:calmendar/src/views/screens/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}



class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor = ref.watch(seedColorController);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calmendar',
      theme: ThemeData(
        textTheme: GoogleFonts.onestTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
