part of 'ticket_cubit.dart';

class TicketState extends Equatable {
  final Ticket ticket;

  const TicketState(this.ticket);

  @override
  List<Object> get props => [ticket];
}
