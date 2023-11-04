import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/launchpad.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/widgets/new_button.dart';
import 'package:milkboard/window_object.dart';
import 'package:super_context_menu/super_context_menu.dart';

class TaskBar extends ConsumerWidget {
  const TaskBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windows = ref.watch(windowsProvider);
    final normalWindows =
        windows.where((window) => window.type == WindowType.normal).toList();
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ]),
        clipBehavior: Clip.antiAlias,
        height: 64,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Row(
            children: [
              // 启动器按钮
              NSButton(
                padding: EdgeInsets.zero,
                child: const SizedBox(
                  height: 64,
                  width: 64,
                  child: Icon(Icons.grid_view_rounded, size: 32),
                ),
                onPressed: () {
                  ref.read(launchingProvider.notifier).toggle();
                },
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  // children: [
                  //   for (final window in windows)
                  //     if (window.type == WindowType.normal)
                  //       NSButton(
                  //         onPressed: () {
                  //           ref.read(windowsProvider.notifier).top(window);
                  //         },
                  //         child: Container(
                  //           color: Colors.transparent,
                  //           child: Center(
                  //             child: Text(window.title),
                  //           ),
                  //         ),
                  //       ),
                  // ],
                  // 改成builder
                  scrollDirection: Axis.horizontal,
                  itemCount: normalWindows.length,
                  itemBuilder: (context, index) {
                    final window = normalWindows[index];
                    return ContextMenuWidget(
                      deferredPreviewBuilder:
                          (context, child, cancellationToken) =>
                              DeferredMenuPreview(
                        screenSize / 5,
                        (() async => Material(
                              borderRadius: BorderRadius.circular(8),
                              child: window.child,
                            ))(),
                      ),
                      child: Container(
                        height: 64,
                        width: 64,
                        color: Colors.transparent,
                        child: Center(
                          child: window.icon,
                        ),
                      ),
                      menuProvider: (_) {
                        return Menu(
                          children: [
                            MenuAction(
                              title: '打开',
                              callback: () {},
                              image: MenuImage.icon(CupertinoIcons.folder),
                            ),
                            MenuSeparator(),
                            MenuAction(
                              title: '最大化',
                              callback: () {},
                              image:
                                  MenuImage.icon(CupertinoIcons.rectangle_fill),
                            ),
                            MenuAction(
                              title: '最小化',
                              callback: () {},
                              image: MenuImage.icon(CupertinoIcons.minus),
                            ),
                            MenuAction(
                              title: '关闭',
                              callback: () {},
                              attributes:
                                  const MenuActionAttributes(destructive: true),
                              image: MenuImage.icon(CupertinoIcons.xmark),
                            ),
                          ],
                        );
                      },

                      // child: Align(
                      //   alignment: Alignment.bottomLeft,
                      //   child: CupertinoContextMenu(
                      //     // onPressed: () {
                      //     //   ref.read(windowsProvider.notifier).top(window);
                      //     // },
                      //     actions: [
                      //       CupertinoContextMenuAction(
                      //         child: const Text('置顶'),
                      //         onPressed: () {
                      //           ref.read(windowsProvider.notifier).top(window);
                      //         },
                      //       ),
                      //       // CupertinoContextMenuAction(
                      //       //   child: const Text('最小化'),
                      //       //   onPressed: () {
                      //       //     ref.read(windowsProvider.notifier).minimize(window);
                      //       //   },
                      //       // ),
                      //       // CupertinoContextMenuAction(
                      //       //   child: const Text('最大化'),
                      //       //   onPressed: () {
                      //       //     ref.read(windowsProvider.notifier).maximize(window);
                      //       //   },
                      //       // ),
                      //       // CupertinoContextMenuAction(
                      //       //   child: const Text('关闭'),
                      //       //   onPressed: () {
                      //       //     ref.read(windowsProvider.notifier).close(window);
                      //       //   },
                      //       // ),
                      //     ],
                      //     child:
                      //   ),
                    );
                  },
                  // itemBuilder: (context, index) => NSButton(
                  //   onPressed: () {
                  //     ref.read(windowsProvider.notifier).top(windows[index]);
                  //   },
                  //   child: Container(
                  //     color: Colors.transparent,
                  //     child: Center(
                  //       child: windows[index].icon,
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
