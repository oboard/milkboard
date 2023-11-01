import 'package:flutter/material.dart';
import 'package:milkboard/title_bar.dart';
import 'package:milkboard/window_object.dart';

class WindowFrame extends StatelessWidget {
  const WindowFrame({super.key, required this.widget});

  final WindowObject widget;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    switch (widget.type) {
      case WindowType.normal:
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
          // constraints: BoxConstraints(
          //   minHeight: 100,
          //   minWidth: 100,
          //   maxHeight: MediaQuery.of(context).size.height - 48,
          //   maxWidth: MediaQuery.of(context).size.width,
          // ),
          child: Column(
            children: [
              TitleBar(widget),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        );
      case WindowType.fullscreen:
        return widget.child;
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
              TitleBar(widget),
              Expanded(
                child: widget.child,
              ),
            ],
          ),
        );
    }
  }
}
