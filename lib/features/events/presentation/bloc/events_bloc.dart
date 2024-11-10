import 'package:bloc/bloc.dart';
import 'package:tickoyakovendors/features/events/data/models/event_model.dart';
import 'package:tickoyakovendors/features/events/data/repositories/events_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventsRepository repository;

  EventsBloc(this.repository) : super(EventsInitial()) {
    on<FetchEvents>((event, emit) async {
      try {
        emit(EventsLoading());
        final events = await repository.getEvents();
        emit(EventsLoaded(events));
      } catch (e) {
        emit(EventsError(e.toString()));
      }
    });
  }
}
