import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'widgets.dart';

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.passthrough,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                // color: Colors.black26,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  '${state.value}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const Spacer(),
                GestureDetector(
                  onLongPress: () {
                    state.value = minimum;
                    onChange(minimum);
                  },
                  child: CircularIconButton(
                    color: Theme.of(context).errorColor,
                    icon: LineAwesomeIcons.minus,
                    onPressed: () {
                      if (state.value <= minimum) {
                        return;
                      }
                      state.value = state.value - defaultStep as T;
                      onChange(state.value);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                CircularIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: LineAwesomeIcons.plus,
                  onPressed: () {
                    state.value = state.value + defaultStep as T;
                    onChange(state.value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
