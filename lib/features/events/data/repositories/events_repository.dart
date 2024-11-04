import '../models/event_model.dart';

class EventsRepository {
  // Simulate API call with dummy data
  Future<List<EventsModel>> getEvents() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    return [
      EventsModel(
        id: '1',
        contact: '+1234567890',
        eventOwner: 'John Doe',
        price: 50,
        type: 'Concert',
        venue: 'Central Park',
        imgUrl: 'https://img.freepik.com/free-vector/abstract-music-festival-poster-template_23-2148233165.jpg?semt=ais_hybrid',
        title: 'Summer Music Festival',
        description: 'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
        date: DateTime.now().add(const Duration(days: 7)),
      ),
      EventsModel(
        id: '2',
        contact: '+0987654321',
        eventOwner: 'Jane Smith',
        price: 30,
        type: 'Theater',
        venue: 'City Theater',
        imgUrl:  'https://mir-s3-cdn-cf.behance.net/project_modules/hd/52c1d474688221.5c37353ba9d5d.jpg',
        title: 'Romeo and Juliet',
        description: 'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
        date: DateTime.now().add(const Duration(days: 14)),
      ),
        EventsModel(
        id: '1',
        contact: '+1234567890',
        eventOwner: 'John Doe',
        price: 50,
        type: 'comedy',
        venue: 'Central Park',
        imgUrl:
            'https://img.freepik.com/premium-psd/comedy-show-poster-social-media-instagram-post-template_69464-4106.jpg',
        title: 'Summer comedy Festival',
        description: 'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
        date: DateTime.now().add(const Duration(days: 7)),
      ),
      EventsModel(
        id: '2',
        contact: '+0987654321',
        eventOwner: 'Jane Smith',
        price: 30,
        type: 'Theater',
        venue: 'City Theater',
        imgUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXR03yxPJrV7LIPkULnGW5EoWDjiCLCCPE5w&s',
        title: 'Romeo and Juliet',
        description: 'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
        date: DateTime.now().add(const Duration(days: 14)),
      ),
        EventsModel(
        id: '1',
        contact: '+1234567890',
        eventOwner: 'John Doe',
        price: 50,
        type: 'Concert',
        venue: 'Central Park',
        imgUrl:
            'https://images.squarespace-cdn.com/content/v1/5e7a8f6d95bc3643e73bc2e8/1616364429636-5W45LYN05KGSAYO53YJB/MP_Raya_classic.jpeg',
        title: 'Summer Music Festival',
        description: 'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
        date: DateTime.now().add(const Duration(days: 7)),
      ),
      EventsModel(
        id: '2',
        contact: '+0987654321',
        eventOwner: 'Jane Smith',
        price: 30,
        type: 'Theater',
        venue: 'City Theater',
        imgUrl:
            'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/podcast-talk-show-flyer-poster-design-template-1f54ecf57097f18eb3ccb52ee412760a_screen.jpg?ts=1647566159',
        title: 'Romeo and Juliet',
        description: 'Like The Conjuring, Annabelle is based on one of the famous cases taken on by paranormal investigators Ed and Lorraine Warren',
        date: DateTime.now().add(const Duration(days: 14)),
      ),
    ];
  }
}
