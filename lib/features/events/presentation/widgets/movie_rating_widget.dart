import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickoyakovendors/features/events/presentation/bloc/events_bloc.dart';

class MovieRatingWidget extends StatelessWidget {
  final String movieId;

  const MovieRatingWidget({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        if (state is MovieRatingLoading) {
          return const CircularProgressIndicator();
        } else if (state is MovieRatingLoaded) {
          return Text('Rating: ${state.rating}');
        } else if (state is MovieRatingError) {
          return Text('Error: ${state.message}');
        }
        return ElevatedButton(
          onPressed: () {
            context.read<EventsBloc>().add(FetchMovieRating(movieId));
          },
          child: const Text('Load Rating'),
        );
      },
    );
  }
}
