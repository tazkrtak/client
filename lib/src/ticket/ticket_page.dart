import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../l10n/tr.dart';
import '../app/cubits/session_cubit.dart';
import 'cubits/ticket_cubit.dart';
import 'picker.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TicketCubit(
          (context.read<SessionCubit>().state as SessionSuccess).user.id),
      child: Column(
        children: [
          const SizedBox(height: 20),
          BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
            return QrImage(
              data: state.ticket.value.toString(),
              size: 250.0,
            );
          }),
          const SizedBox(height: 20),
          BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
            return Picker(
              label: tr(context).ticket_quantityTitle.toString(),
              vaule: state.ticket.quantity,
              onChange: (quantity) {
                context.read<TicketCubit>().updateQuantity(quantity as int);
              },
              minimum: TicketCubit.kMinQuantity,
            );
          }),
          const SizedBox(height: 20),
          BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
            return Picker(
              label: tr(context).ticket_priceTitle.toString(),
              vaule: state.ticket.price,
              onChange: (price) {
                context.read<TicketCubit>().updatePrice(price as double);
              },
              minimum: TicketCubit.kMinPrice,
            );
          }),
        ],
      ),
    );
  }
}
