import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/window_object.dart';

class TaskBar extends ConsumerWidget {
  const TaskBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windows = ref.watch(windowsProvider);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white30,
      ),
      clipBehavior: Clip.hardEdge,
      height: 48,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Row(
          children: [
            for (final window in windows)
              if (window.type == WindowType.normal)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      ref.read(windowsProvider.notifier).top(window);
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: Text(window.title),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
