import 'package:flutter/material.dart';

enum WindowState {
  normal,
  minimized,
  maximized,
  closing,
}

enum WindowType {
  normal,
  fullscreen,
  dialog,
}

class WindowObject {
  // 构造
  WindowObject({
    this.title = '',
    this.icon = const Icon(Icons.ac_unit),
    required this.child,
    this.position = const Offset(0, 0),
    this.size = const Size(1, 1),
    this.type = WindowType.normal,
    this.state = WindowState.normal,
    this.zIndex = 0,
  });

  String title = '';
  Widget child = const SizedBox();
  Widget icon = const Icon(Icons.ac_unit);
  Offset position = const Offset(0, 0);
  Size size = const Size(1, 1);
  WindowState state = WindowState.normal;
  WindowType type = WindowType.normal;
  int zIndex = 0;

  WindowObject copyWith(
      {String? title,
      Widget? icon,
      Widget? child,
      Offset? position,
      Size? size,
      WindowState? state,
      WindowType? type,
      int? order}) {
    return WindowObject(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      child: child ?? this.child,
      position: position ?? this.position,
      size: size ?? this.size,
      state: state ?? this.state,
      type: type ?? this.type,
      zIndex: order ?? this.zIndex,
    );
  }
}

// class WindowObject extends StatefulWidget {
//   const WindowObject({super.key, required this.child, required this.title});

//   final Widget child;
//   final String title;

//   @override
//   State<WindowObject> createState() => _WindowObjectState();
// }

// class _WindowObjectState extends State<WindowObject> {
//   @override
//   Widget build(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     return Container(
//       decoration: BoxDecoration(
//         color: colorScheme.surface,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       constraints: BoxConstraints(
//         minHeight: 100,
//         minWidth: 100,
//         maxHeight: MediaQuery.of(context).size.height - 48,
//         maxWidth: MediaQuery.of(context).size.width,
//       ),
//       child: Column(
//         children: [
//           TitleBar(title: widget.title),
//           Expanded(
//             child: widget.child,
//           ),
//         ],
//       ),
//     );
//   }
// }
