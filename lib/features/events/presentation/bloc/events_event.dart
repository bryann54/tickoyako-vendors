part of 'events_bloc.dart';

abstract class EventsEvent {}

class FetchEvents extends EventsEvent {}

class FetchMovieRating extends EventsEvent {
  final String movieId;

  FetchMovieRating(this.movieId);
}
