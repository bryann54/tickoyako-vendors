
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  final String apiKey;
  final String accessToken;

  ApiService({
    required this.baseUrl,
    required this.apiKey,
    required this.accessToken,
  });

  // Example of a GET request
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    return await http.get(url, headers: _headers());
  }

  // Private method to include API Key and Token in headers
  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $accessToken',
      'x-api-key': apiKey,
      'Content-Type': 'application/json',
    };
  }
}
