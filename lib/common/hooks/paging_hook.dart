import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<int, Model> usePagingController<Model>(
    int firstPageKey, Future<void> Function(int) fetchMethod) {
  return use(_PagingControllerHook<Model>(
    firstPageKey: firstPageKey,
    fetchMethod: fetchMethod,
  ));
}

class _PagingControllerHook<Model> extends Hook<PagingController<int, Model>> {
  final int firstPageKey;
  final Future<void> Function(int) fetchMethod;

  const _PagingControllerHook({
    required this.firstPageKey,
    required this.fetchMethod,
  });

  @override
  HookState<PagingController<int, Model>, Hook<PagingController<int, Model>>>
      createState() =>
          _PagingControllerHookState<Model>(firstPageKey, fetchMethod);
}

class _PagingControllerHookState<Model> extends HookState<
    PagingController<int, Model>, _PagingControllerHook<Model>> {
  late PagingController<int, Model> pagingController;
  final int firstPageKey;
  final Future<void> Function(int) fetchMethod;

  _PagingControllerHookState(this.firstPageKey, this.fetchMethod);

  @override
  void initHook() {
    pagingController = PagingController<int, Model>(firstPageKey: firstPageKey);
    pagingController.addPageRequestListener(fetchMethod);
  }

  @override
  PagingController<int, Model> build(BuildContext context) => pagingController;

  @override
  void dispose() => pagingController.dispose();
}
