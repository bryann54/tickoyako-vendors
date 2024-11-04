import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ticket_scanning_event.dart';
part 'ticket_scanning_state.dart';

class TicketScanningBloc extends Bloc<TicketScanningEvent, TicketScanningState> {
  TicketScanningBloc() : super(TicketScanningInitial()) {
    on<TicketScanningEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
