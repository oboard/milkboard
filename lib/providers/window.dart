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
  title: 'Background',
  type: WindowType.fullscreen,
  child: const Align(
    alignment: Alignment.bottomCenter,
    child: TaskBar(),
  ),
);

final windowsProvider =
    StateNotifierProvider<WindowsNotifier, List<WindowObject>>(
  (ref) => WindowsNotifier([
    _backgroundWindow,
    _toolBarWindow,
    WindowObject(
      child: const Center(
        child: Text('Hello World'),
      ),
      size: const Size(0.5, 0.5),
    ),
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
}
