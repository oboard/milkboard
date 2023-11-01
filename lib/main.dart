import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/window_manager.dart';

void main() {
  runApp(const ProviderScope(child: MilkBoardApp()));
}

class MilkBoardApp extends StatelessWidget {
  const MilkBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MilkBoard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WindowManager(),
    );
  }
}
