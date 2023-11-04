import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/applications/application_list.dart';
import 'package:milkboard/applications/hello_world.dart';
import 'package:milkboard/providers/launchpad.dart';
import 'package:milkboard/providers/window.dart';
import 'package:milkboard/widgets/new_button.dart';
import 'package:milkboard/window_object.dart';

class LaunchPad extends ConsumerWidget {
  const LaunchPad({super.key});

  Widget _buildGridItem(
      BuildContext context, WidgetRef ref, WindowObject windowObject) {
    final screenSize = MediaQuery.of(context).size;
    final double width = screenSize.width / 10;
    return NSButton(
      onPressed: () {
        ref.read(launchingProvider.notifier).toggle();
        ref.read(windowsProvider.notifier).add(
              WindowObject(
                title: windowObject.title,
                icon: windowObject.icon,
                child: windowObject.child,
                type: WindowType.normal,
                size: const Size(0.5, 0.5),
                position: const Offset(0.25, 0.25),
              ),
            );
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: windowObject.icon,
            ),
            const SizedBox(height: 10),
            Text(
              windowObject.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 5,
      children:
          applications.map((e) => _buildGridItem(context, ref, e)).toList(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // launchingProvider
    final launching = ref.watch(launchingProvider);
    // final colorScheme = Theme.of(context).colorScheme;
    return AnimatedOpacity(
      opacity: launching ? 1 : 0,
      curve: Curves.easeOutCirc,
      duration: const Duration(milliseconds: 300),
      child: AnimatedScale(
        scale: launching ? 1 : 0,
        curve: Curves.easeOutCirc,
        duration: const Duration(milliseconds: 300),
        child: Stack(
          children: [
            Positioned.fill(child: backgroundWindow.child),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.black26,
              ),
              child: _buildGrid(context, ref),
            ),
          ],
        ),
      ),
    );
  }
}
