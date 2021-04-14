import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NumberPicker<T extends num> extends HookWidget {
  final T? initialValue;
  final T minimum;
  final T step;
  final String label;
  final Function(T) onChange;

  const NumberPicker({
    this.initialValue,
    this.minimum = 0 as T,
    this.step = 1 as T,
    required this.label,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final valueState = useState(initialValue ?? minimum);

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
            valueState.value = valueState.value - step as T;
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
            valueState.value = valueState.value + step as T;
            onChange(valueState.value);
          },
        ),
      ],
    );
  }
}
