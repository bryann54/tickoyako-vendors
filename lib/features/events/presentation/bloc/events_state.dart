part of 'events_bloc.dart';

abstract class EventsState {}

class EventsInitial extends EventsState {}

class EventsLoading extends EventsState {}

class EventsLoaded extends EventsState {
  final List<EventsModel> events;
  EventsLoaded(this.events);
}

class EventsError extends EventsState {
  final String message;
  EventsError(this.message);
}
class MovieRatingLoading extends EventsState {}

class MovieRatingLoaded extends EventsState {
  final double rating;
  MovieRatingLoaded(this.rating);
}

class MovieRatingError extends EventsState {
  final String message;
  MovieRatingError(this.message);
}

