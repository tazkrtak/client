import 'dart:math';

import '../../src/wallet/transactions/models/transaction.dart';

class DummyPage<T> {
  final int pageKey;
  final int pageSize;
  final List<T> data;

  DummyPage({
    required this.pageKey,
    required this.pageSize,
    required this.data,
  });
}

class TransactionsServiceMock {
  static final _random = Random();

  static final _dataSource = List.generate(
    21,
    (i) => Transaction(
      date: DateTime.now(),
      amount: (_random.nextBool() ? 1 : -1) * _random.nextInt(15).toDouble(),
      reason: 'Pay for bus',
    ),
  );

  Future<DummyPage<Transaction>> fetch(int page, int size) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        if (_random.nextBool()) {
          throw ('Newtork error!');
        }

        final offset = page * size;
        final data = _dataSource.skip(offset).take(size).toList();

        return DummyPage<Transaction>(
          data: data,
          pageKey: page,
          pageSize: data.length,
        );
      },
    );
  }
}
