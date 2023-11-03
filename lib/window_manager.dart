import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/window_frame.dart';
import 'package:milkboard/window_object.dart';

class WindowManager extends ConsumerWidget {
  const WindowManager({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windows = ref.watch(windowsProvider);
    final screenSize = MediaQuery.of(context).size;
    // 按照zIndex排序
    windows.sort((a, b) => a.zIndex.compareTo(b.zIndex));
    return Scaffold(
      body: Stack(
        children: [
          for (final window in windows)
            if (window.state == WindowState.normal)
              Positioned(
                left: window.position.dx * screenSize.width,
                top: window.position.dy * screenSize.height,
                width: window.size.width * screenSize.width,
                height: window.size.height * screenSize.height,
                child: WindowFrame(window: window),
              )
            else if (window.state == WindowState.maximized)
              Positioned(
                left: 0,
                top: 0,
                width: screenSize.width,
                height: screenSize.height,
                child: WindowFrame(window: window),
              ),
        ],
      ),
    );
  }
}
