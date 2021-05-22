import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<int, T> usePagingController<T>(
  Future<void> Function(int) listener,
) {
  return use(_ControllerHook<T>(fetchMethod: listener));
}

class _ControllerHook<T> extends Hook<PagingController<int, T>> {
  final Future<void> Function(int) fetchMethod;

  const _ControllerHook({
    required this.fetchMethod,
  });

  @override
  _ControllerHookState<T> createState() => _ControllerHookState<T>();
}

class _ControllerHookState<T>
    extends HookState<PagingController<int, T>, _ControllerHook<T>> {
  final PagingController<int, T> pagingController = PagingController<int, T>(
    firstPageKey: 1,
  );

  @override
  void initHook() {
    super.initHook();
    pagingController.addPageRequestListener(hook.fetchMethod);
  }

  @override
  PagingController<int, T> build(BuildContext context) => pagingController;

  @override
  void dispose() => pagingController.dispose();
}
