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
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      // 拖拽移动
      onPanStart: (details) {
        offsetPosition = details.localPosition;
      },
      onPanUpdate: (details) {
        Offset newGlobalPosition = details.globalPosition;
        newGlobalPosition = Offset(
          newGlobalPosition.dx / screenSize.width,
          newGlobalPosition.dy / screenSize.height,
        );
        Offset newPosition = newGlobalPosition - offsetPosition;
        newPosition = Offset(
          newPosition.dx.clamp(0, 1),
          newPosition.dy.clamp(0, 1),
        );
        ref.read(windowsProvider.notifier).updatePosition(
              window,
              newPosition,
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
