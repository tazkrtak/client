import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../l10n/tr.dart';
import '../../widgets/widgets.dart';
import '../app/cubits/session_cubit.dart';
import 'cubits/ticker_cubit.dart';
import 'cubits/ticket_cubit.dart';
import 'util/totp.dart';

class TicketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = (context.read<SessionCubit>().state as SessionSuccess).user;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TicketCubit(
            user.id,
            Totp.generateCode(user.secret),
          ),
        ),
        BlocProvider(
          create: (_) => TickerCubit()..start(Totp.expiresIn),
        ),
      ],
      child: BlocListener<TickerCubit, TickerState>(
        listener: (context, state) {
          if (state.finished) {
            context
                .read<TicketCubit>()
                .updateTotp(Totp.generateCode(user.secret));
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<TicketCubit, TicketState>(builder: (context, state) {
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
                  size: 250.0,
                ),
              );
            }),
            const SizedBox(height: 20),
            BlocBuilder<TickerCubit, TickerState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      width: 64,
                      child: LinearProgressIndicator(
                        value: state.count.toDouble() / Totp.interval,
                      ),
                    ),
                    Text(state.count.toString())
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            NumberPicker<int>(
              label: tr(context).ticket_quantityTitle,
              minimum: TicketCubit.kMinQuantity,
              onChange: (value) {
                context.read<TicketCubit>().updateQuantity(value);
              },
            ),
            const SizedBox(height: 20),
            NumberPicker<double>(
              label: tr(context).ticket_priceTitle,
              minimum: TicketCubit.kMinPrice,
              onChange: (value) {
                context.read<TicketCubit>().updatePrice(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
