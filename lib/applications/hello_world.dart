import 'package:flutter/material.dart';
import 'package:milkboard/window_object.dart';

class HelloWorld extends WindowObject {
  HelloWorld()
      : super(
          title: 'Hello World',
          child: const Center(
            child: Text('Hello World'),
          ),
          size: const Size(0.5, 0.5),
        );
}
