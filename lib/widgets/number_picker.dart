import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NumberPicker<T extends num> extends HookWidget {
  final T? initialValue;
  final T? step;
  final T minimum;
  final String label;
  final Function(T) onChange;

  const NumberPicker({
    this.initialValue,
    this.step,
    required this.minimum,
    required this.label,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final state = useState(initialValue ?? minimum);
    final defaultStep = step ?? 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.remove,
            color: Colors.red,
          ),
          onPressed: () {
            if (state.value <= minimum) {
              return;
            }
            state.value = state.value - defaultStep as T;
            onChange(state.value);
          },
        ),
        Text('$label: ${state.value}'),
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.green,
          ),
          onPressed: () {
            state.value = state.value + defaultStep as T;
            onChange(state.value);
          },
        ),
      ],
    );
  }
}
