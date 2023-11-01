import 'package:flutter/material.dart';

enum WindowState {
  normal,
  minimized,
  maximized,
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
    required this.child,
    this.position = const Offset(0, 0),
    this.size = const Size(1, 1),
    this.type = WindowType.normal,
  });

  String title = '';
  Widget child = const SizedBox();
  Offset position = const Offset(0, 0);
  Size size = const Size(1, 1);
  WindowType type = WindowType.normal;

  WindowObject copyWith(
      {String? title,
      Widget? child,
      Offset? position,
      Size? size,
      WindowType? type}) {
    return WindowObject(
      title: title ?? this.title,
      child: child ?? this.child,
      position: position ?? this.position,
      size: size ?? this.size,
      type: type ?? this.type,
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
