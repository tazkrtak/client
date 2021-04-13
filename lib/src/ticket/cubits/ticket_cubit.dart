import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../api/user/models/ticket.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  static const double kMinPrice = 3;
  static const int kMinQuantity = 1;
  final String userId;

  TicketCubit(this.userId)
      : super(
          TicketState(
            Ticket(
              price: kMinPrice,
              quantity: kMinQuantity,
              userId: userId,
              totp: '123456',
            ),
          ),
        );

  void quantityUpdate(int quantity) {
    emit(
      TicketState(
        state.ticket.copyWith(
          quantity: state.ticket.quantity < kMinQuantity
              ? state.ticket.quantity
              : kMinQuantity,
        ),
      ),
    );
  }

  void priceUpdate(double price) {
    emit(
      TicketState(
        state.ticket.copyWith(
          price:
              state.ticket.price < kMinPrice ? state.ticket.price : kMinPrice,
        ),
      ),
    );
  }

  void updateTotp(String totp) {
    emit(
      TicketState(
        state.ticket.copyWith(
          totp: state.ticket.totp,
        ),
      ),
    );
  }
}
