import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/window_object.dart';

Offset offsetPosition = const Offset(0, 0);

class TitleBar extends ConsumerWidget {
  const TitleBar(this.window, {super.key});

  final WindowObject window;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      // 拖拽移动
      onPanStart: (details) {
        offsetPosition = details.localPosition;
      },
      onPanUpdate: (details) {
        ref.read(windowsProvider.notifier).updatePosition(
              window,
              details.globalPosition - offsetPosition,
            );
      },

      child: Container(
        color: colorScheme.primaryContainer,
        height: 48,
        child: Row(
          children: [
            const Spacer(),
            Text(window.title),
            const Spacer(),
            const SizedBox(width: 8),
            const Icon(Icons.close),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
