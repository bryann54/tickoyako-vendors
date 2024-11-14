import 'package:flutter/material.dart';
import 'package:tickoyakovendors/features/events/data/models/event_model.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/event_card_widget.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/movie_rating_widget.dart';

// class EventsList extends StatelessWidget {
//   final List<EventsModel> events;

//   const EventsList({Key? key, required this.events}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: events.length,
//       itemBuilder: (context, index) {
//         return EventCardWidget(event: events[index]);
//       },
//     );
//   }
// }

class EventsList extends StatelessWidget {
  final List<EventsModel> events;

  const EventsList({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Column(
          children: [
            EventCardWidget(event: event),
            // If you want to display movie ratings for specific events,
            // you can add a condition here
            if (event.type.toLowerCase() == 'movie') // Or any other condition
            MovieRatingWidget(
  movieId: event.movieId ?? event.id,
  // Falls back to event.id if movieId is null
),
            const SizedBox(height: 16), // Spacing between items
          ],
        );
      },
    );
  }
}
