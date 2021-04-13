import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Picker extends HookWidget {
  final num value;
  final String label;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const Picker(
      {required this.value,
      required this.label,
      required this.onIncrement,
      required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            icon: const Icon(Icons.remove, color: Colors.red),
            onPressed: onDecrement),
        Text('$label:'),
        IconButton(
            icon: const Icon(Icons.add, color: Colors.green),
            onPressed: onIncrement),
      ],
    );
  }
}
