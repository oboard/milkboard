import 'package:flutter_riverpod/flutter_riverpod.dart';

// final launchingProvider = StateProvider((ref) => false);

// 添加Notifier

final launchingProvider = StateNotifierProvider<LaunchingNotifier, bool>(
  (ref) => LaunchingNotifier(false),
);

class LaunchingNotifier extends StateNotifier<bool> {
  LaunchingNotifier(bool state) : super(state);

  void toggle() {
    state = !state;
  }
}
