import 'package:dio/dio.dart';
import 'package:tickoyakovendors/core/network/api_config.dart';
import '../models/event_model.dart';

class EventsRepository {
  final Dio _dio;
static final List<EventsModel> _events = [
    EventsModel(
      id: '1',
      contact: '+1234567890',
      eventOwner: 'John Doe',
      price: 50,
      type: 'Movie',
      venue: 'Central Cinema',
      imgUrl: 'https://example.com/movie-poster.jpg',
      title: 'The Shawshank Redemption',
      description: 'Special screening of the classic movie',
      date: DateTime.now().add(const Duration(days: 7)),
      movieId: 'tt0111161', // Add the IMDB ID for movies
    ),
    // Other events...
  ];

  EventsRepository() : _dio = Dio() {
    _dio.options.headers = {
      'X-RapidAPI-Key': ApiConfig.apiKey,
      'X-RapidAPI-Host': ApiConfig.apiHost,
    };
  }

  // Get all events
  Future<List<EventsModel>> getEvents() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _events;
  }

  // Get movie rating
  Future<double> getMovieRating(String movieId) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/ratings',
        queryParameters: {'id': movieId},
      );

      if (response.statusCode == 200) {
        return response.data['rating'].toDouble();
      } else {
        throw Exception('Failed to load movie rating');
      }
    } catch (e) {
      throw Exception('Error fetching movie rating: $e');
    }
  }

  // Add new event (your existing method)
  Future<void> addEvent(Map<String, dynamic> eventData) async {
    // Your existing implementation...
  }
}
