import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../l10n/tr.dart';
import '../../widgets/total_amount.dart';
import '../../widgets/widgets.dart';
import '../app/cubits/session_cubit.dart';
import 'cubits/ticket_cubit.dart';
import 'cubits/totp_cubit.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = (context.read<SessionCubit>().state as SessionSuccess).user;

    return BlocProvider(
      create: (_) => TotpCubit(user.secret)..start(),
      child: Builder(
        builder: (context) => BlocProvider(
          create: (_) => TicketCubit(
            user.id,
            user.key,
            context.read<TotpCubit>().state.totp,
          ),
          child: _TicketView(),
        ),
      ),
    );
  }
}

class _TicketView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<TotpCubit, TotpState>(
      listener: (context, state) {
        if (state.isNewInterval) {
          context.read<TicketCubit>().updateTotp(state.totp);
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              BlocBuilder<TotpCubit, TotpState>(
                builder: (context, state) {
                  return RRectProgressIndicator(
                    size: 228,
                    value: state.progress,
                  );
                },
              ),
              BlocBuilder<TicketCubit, TicketState>(
                builder: (context, state) {
                  return GestureDetector(
                    onLongPressUp: () {
                      // TODO: use envrinoment variables
                      if (kReleaseMode) return;

                      // Copies the Ticket's QR code to test it on CCimulator
                      // https://ccimulator.netlify.app/
                      Clipboard.setData(
                        ClipboardData(
                          text: state.ticket.encodedValue,
                        ),
                      );

                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                            content: Text('Ticket copied to clipboard'),
                          ),
                        );
                    },
                    child: QrImage(
                      data: state.ticket.encodedValue,
                      size: 204.0,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 48),
          BlocBuilder<TicketCubit, TicketState>(
            builder: (context, state) {
              return TotalAmount(
                totalAmount: state.ticket.totalAmount,
              );
            },
          ),
          const SizedBox(height: 48),
          NumberPicker<int>(
            label: tr(context).ticket_quantityTitle,
            minimum: TicketCubit.kMinQuantity,
            onChange: (value) {
              context.read<TicketCubit>().updateQuantity(value);
            },
          ),
          const SizedBox(height: 16),
          NumberPicker<double>(
            label: tr(context).ticket_priceTitle,
            step: 0.5,
            minimum: TicketCubit.kMinPrice,
            onChange: (value) {
              context.read<TicketCubit>().updatePrice(value);
            },
          )
        ],
      ),
    );
  }
}
