import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Picker extends HookWidget {
  final num vaule;
  final num minimum;
  final num step;
  final String label;
  final Function(num) onChange;

  const Picker({
    required this.vaule,
    required this.label,
    required this.onChange,
    required this.minimum,
    this.step = 1,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(vaule);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.red,
          ),
          onPressed: () {
            if (valueState.value <= minimum) {
              return;
            }
            valueState.value -= step;
            onChange(valueState.value);
          },
        ),
        Text('$label: ${valueState.value}'),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.green,
          ),
          onPressed: () {
            valueState.value += step;
            onChange(valueState.value);
          },
        ),
      ],
    );
  }
}
