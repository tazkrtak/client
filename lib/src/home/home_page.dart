import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import 'cubits/hello_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<HelloCubit, HelloState>(
          builder: (_, state) {
            if (state is HelloLoading) {
              return Text(tr(context).common_loading);
            } else if (state is HelloSuccess) {
              return Text(state.message);
            } else {
              return Text(tr(context).error_generic);
            }
          },
        ),
      ),
    );
  }
}
