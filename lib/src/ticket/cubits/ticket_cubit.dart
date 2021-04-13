import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../api/user/models/ticket.dart';
part 'ticket_state.dart';

class TicketCubit extends Cubit<TicketState> {
  final String userId;
  static double kminPrice = 1;
  static int kminQuantity = 3;

  TicketCubit(this.userId)
      : super(TicketState(Ticket(
            price: kminPrice,
            quantity: kminQuantity,
            userId: userId,
            totp: '123456')));

  void quantityUpdate(int quantity) => emit(TicketState(state.ticket.copyWith(
      quantity: state.ticket.quantity < kminQuantity
          ? state.ticket.quantity
          : kminQuantity)));

  void priceUpdate(double price) => emit(TicketState(state.ticket.copyWith(
      price: state.ticket.price < kminPrice ? state.ticket.price : kminPrice)));

  void updateTotp(String totp) =>
      emit(TicketState(state.ticket.copyWith(totp: state.ticket.totp)));
}
