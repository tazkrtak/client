import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<int, T> usePagingController<T>(
  Future<void> Function(int) listener,
) {
  return use(_ControllerHook<T>(
    listener: listener,
  ));
}

class _ControllerHook<T> extends Hook<PagingController<int, T>> {
  final Future<void> Function(int) listener;

  const _ControllerHook({
    required this.listener,
  });

  @override
  _ControllerHookState<T> createState() => _ControllerHookState<T>();
}

class _ControllerHookState<T>
    extends HookState<PagingController<int, T>, _ControllerHook<T>> {
  final PagingController<int, T> controller = PagingController<int, T>(
    firstPageKey: 0,
  );

  @override
  void initHook() {
    super.initHook();
    controller.addPageRequestListener(hook.listener);
  }

  @override
  PagingController<int, T> build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();
}
