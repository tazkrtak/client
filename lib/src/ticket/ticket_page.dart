import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/tr.dart';
import 'cubits/ticket_cubit.dart';
import 'picker.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.qr_code,
          size: 200,
        ),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
          return Picker(
            label: tr(context).quantity_title.toString(),
            value: state.ticket.quantity,
            onDecrement: () => Null,
            onIncrement: () => Null,
          );
        }),
        const SizedBox(
          height: 16,
        ),
        BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
          return Picker(
            label: tr(context).price_title.toString(),
            value: state.ticket.price,
            onDecrement: () => Null,
            onIncrement: () => Null,
          );
        }),
      ],
    );
  }
}
