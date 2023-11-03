import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/title_bar.dart';
import 'package:milkboard/window_object.dart';

Offset startPosition = const Offset(0, 0);
Offset focalPosition = const Offset(0, 0);
Size oldSize = const Size(0, 0);

class WindowFrame extends ConsumerWidget {
  const WindowFrame({super.key, required this.window});

  final WindowObject window;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    switch (window.type) {
      case WindowType.normal:
        return GestureDetector(
          onTap: () => ref.read(windowsProvider.notifier).top(window),
          // 三指移动
          // 判断是否是三指
          onScaleStart: (details) {
            // if (details.pointerCount == 3) {
            // 记录当前位置

            // 置顶
            if (ref.read(windowsProvider.notifier).getTop() != window.zIndex) {
              window.zIndex = ref.read(windowsProvider.notifier).getTop() + 1;
            }

            startPosition = window.position;
            // 记录当前中心点
            focalPosition = Offset(
              details.localFocalPoint.dx / screenSize.width,
              details.localFocalPoint.dy / screenSize.height,
            );
            // 记录当前大小
            oldSize = window.size;

            // }
          },
          onScaleUpdate: (details) {
            if (details.pointerCount >= 3 &&
                ref.read(windowsProvider.notifier).isActive(window)) {
              // 缩放
              // 计算新大小
              Size newSize = oldSize * details.scale;
              // 限制新大小
              newSize = Size(
                newSize.width.clamp(0.5, 1),
                newSize.height.clamp(0.5, 1),
              );
              // 更新大小
              window.size = newSize;
              // 中心缩放，要更新位置
              // 计算新位置

              // 计算新位置
              Offset newPosition = Offset(
                    details.focalPoint.dx / screenSize.width,
                    details.focalPoint.dy / screenSize.height,
                  ) -
                  focalPosition;
              // 限制新位置
              newPosition = Offset(
                newPosition.dx.clamp(0, 1 - window.size.width),
                newPosition.dy.clamp(0, 1 - window.size.height),
              );
              // 更新位置

              ref.read(windowsProvider.notifier).updatePosition(
                    window,
                    newPosition,
                  );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            // constraints: BoxConstraints(
            //   minHeight: 100,
            //   minWidth: 100,
            //   maxHeight: MediaQuery.of(context).size.height - 48,
            //   maxWidth: MediaQuery.of(context).size.width,
            // ),
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: [
                  TitleBar(window),
                  Expanded(
                    child: window.child,
                  ),
                ],
              ),
            ),
          ),
        );
      case WindowType.fullscreen:
        return window.child;
      case WindowType.dialog:
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          constraints: BoxConstraints(
            minHeight: 100,
            minWidth: 100,
            maxHeight: MediaQuery.of(context).size.height - 48,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Column(
            children: [
              TitleBar(window),
              Expanded(
                child: window.child,
              ),
            ],
          ),
        );
    }
  }
}
