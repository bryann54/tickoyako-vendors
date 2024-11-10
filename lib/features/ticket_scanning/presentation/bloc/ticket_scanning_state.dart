part of 'ticket_scanning_bloc.dart';

abstract class TicketScanningState extends Equatable {
  const TicketScanningState();

  @override
  List<Object> get props => [];
}

class TicketScanningInitial extends TicketScanningState {}
