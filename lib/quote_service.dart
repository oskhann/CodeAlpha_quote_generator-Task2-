import 'dart:convert';
import 'package:http/http.dart' as http;

class QuoteService {
  static Future<Map<String, String>> fetchQuote() async {
    final response = await http.get(Uri.parse('https://zenquotes.io/api/random'));

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body); // Fix: Decode as a list
      if (data.isNotEmpty) {
        return {
          'content': data[0]['q'], // Fix: Use 'q' for quote text
          'author': data[0]['a']   // Fix: Use 'a' for author
        };
      } else {
        throw Exception('Empty response from API');
      }
    } else {
      throw Exception('Failed to load quote');
    }
  }
}
