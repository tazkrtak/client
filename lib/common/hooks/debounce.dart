import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

typedef DebounceFunction = Function(Function() action);

DebounceFunction useDebounce({
  Duration duration = const Duration(milliseconds: 500),
}) {
  return use(_DebounceHook(duration));
}

class _DebounceHook extends Hook<DebounceFunction> {
  final Duration duration;

  const _DebounceHook(this.duration);

  @override
  _DebounceHookState createState() => _DebounceHookState();
}

class _DebounceHookState extends HookState<DebounceFunction, _DebounceHook> {
  Timer? _debounce;

  @override
  DebounceFunction build(BuildContext context) {
    return (action) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(hook.duration, action);
    };
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
