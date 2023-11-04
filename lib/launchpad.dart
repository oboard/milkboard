import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/providers/launchpad.dart';
import 'package:milkboard/providers/window.dart';

class LaunchPad extends ConsumerWidget {
  const LaunchPad({super.key});

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
              decoration: const BoxDecoration(
                color: Colors.black26,
              ),
              child: const Center(
                child: Text(
                  'MilkBoard',
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
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
