import 'package:flutter/material.dart';
import 'package:tickoyakovendors/features/events/data/models/event_model.dart';
import 'package:tickoyakovendors/features/events/presentation/widgets/event_card_widget.dart';

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
        return EventCardWidget(event: events[index]);
      },
    );
  }
}
