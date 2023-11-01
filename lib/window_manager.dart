import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/task_bar.dart';
import 'package:milkboard/window_frame.dart';

class WindowManager extends ConsumerWidget {
  const WindowManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windows = ref.watch(windowsProvider);
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          for (final window in windows)
            Positioned(
              top: window.position.dy,
              left: window.position.dx,
              width: window.size.width * screenSize.width,
              height: window.size.height * screenSize.height,
              child: WindowFrame(widget: window),
            ),
        ],
      ),
    );
  }
}
