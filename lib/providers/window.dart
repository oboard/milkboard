import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milkboard/task_bar.dart';
import 'package:milkboard/window_object.dart';

final _backgroundWindow = WindowObject(
  title: 'Background',
  type: WindowType.fullscreen,
  child: Image.asset(
    'assets/images/boliviainteligente.jpg',
    fit: BoxFit.cover,
  ),
);

final _toolBarWindow = WindowObject(
  title: 'TaskBar',
  type: WindowType.fullscreen,
  zIndex: 1000,
  child: const Align(
    alignment: Alignment.bottomCenter,
    child: TaskBar(),
  ),
);

final _helloWorldWindow = WindowObject(
  title: 'Hello World',
  child: const Center(
    child: Text('Hello World'),
  ),
  size: const Size(0.5, 0.5),
);

final windowsProvider =
    StateNotifierProvider<WindowsNotifier, List<WindowObject>>(
  (ref) => WindowsNotifier([
    _backgroundWindow,
    _toolBarWindow,
    _helloWorldWindow,
    _helloWorldWindow,
  ]),
);

class WindowsNotifier extends StateNotifier<List<WindowObject>> {
  WindowsNotifier(List<WindowObject> state) : super(state);

  void addItem(WindowObject item) {
    state = [...state, item];
  }

  void removeItem(WindowObject item) {
    state = state.where((element) => element != item).toList();
  }

  void updatePosition(WindowObject item, Offset newPosition) {
    state = state.map((existingItem) {
      if (existingItem == item) {
        return existingItem.copyWith(position: newPosition);
      }
      return existingItem;
    }).toList();
  }

  void top(WindowObject window) {
    // 窗口置顶
    window.zIndex = getTop() + 1;

    state = [...state];
    // state.sort((a, b) => a.zIndex.compareTo(b.zIndex));
  }

  int getTop() {
    return state
        .map((e) => e.type == WindowType.normal ? e.zIndex : 0)
        .reduce((value, element) {
      return (value > element) ? value : element;
    });
  }

  bool isActive(WindowObject window) {
    return window.zIndex == getTop();
  }
}
