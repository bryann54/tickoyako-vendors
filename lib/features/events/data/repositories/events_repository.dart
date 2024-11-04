import '../models/event_model.dart';

class EventsRepository {
  // Static list to maintain events in memory
  static final List<EventsModel> _events = [
    // EventsModel(
    //   id: '1',
    //   contact: '+1234567890',
    //   eventOwner: 'John Doe',
    //   price: 50,
    //   type: 'Concert',
    //   venue: 'Central Park',
    //   imgUrl:
    //       'https://img.freepik.com/free-vector/abstract-music-festival-poster-template_23-2148233165.jpg?semt=ais_hybrid',
    //   title: 'Summer Music Festival',
    //   description:
    //       'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
    //   date: DateTime.now().add(const Duration(days: 7)),
    // ),
   
  ];

  // Get all events
  Future<List<EventsModel>> getEvents() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return _events;
  }

  // Add new event
  Future<void> addEvent(Map<String, dynamic> eventData) async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // Simulate network delay

    // Generate a simple ID (in a real app, this would come from the backend)
    final String newId = (_events.length + 1).toString();

    final newEvent = EventsModel(
      id: newId,
      type: eventData['type'],
      imgUrl: eventData['imgUrl'],
      venue: eventData['venue'],
      title: eventData['title'],
      description: eventData['description'],
      date: DateTime.parse(eventData['date']),
      price: eventData['price'],
      eventOwner: eventData['eventOwner'],
      contact: eventData['contact'],
    );

    _events.add(newEvent);
  }
}
