import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transactions/cubits/transactions_cubit.dart';
import 'transactions/widgets/transactions_list.dart';
import 'widgets/overview_cards.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionsCubit>(
      create: (_) => TransactionsCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => context.read<TransactionsCubit>().refresh(),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        OverViewCards(),
                        const SizedBox(height: 24),
                        TransactionsList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
