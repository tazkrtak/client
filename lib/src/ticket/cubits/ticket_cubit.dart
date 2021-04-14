import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../api/ticket/models/ticket.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  static const double kMinPrice = 3;
  static const int kMinQuantity = 1;
  final String userId;
  final String initialTotp;

  TicketCubit(this.userId, this.initialTotp)
      : super(
          TicketState(
            Ticket(
              price: kMinPrice,
              quantity: kMinQuantity,
              userId: userId,
              totp: initialTotp,
            ),
          ),
        );

  void updateQuantity(int quantity) {
    emit(
      TicketState(
        state.ticket.copyWith(
          quantity: quantity < kMinQuantity ? kMinQuantity : quantity,
        ),
      ),
    );
  }

  void updatePrice(double price) {
    emit(
      TicketState(
        state.ticket.copyWith(
          price: price < kMinPrice ? kMinPrice : price,
        ),
      ),
    );
  }

  void updateTotp(String totp) {
    emit(
      TicketState(
        state.ticket.copyWith(
          totp: totp,
        ),
      ),
    );
  }
}
