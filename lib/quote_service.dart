import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quote_model.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class QuoteService {
  static Future<Quote> fetchRandomQuote() async {
    try {
      await dotenv.load(); // Load .env file
      final apiKey = dotenv.env['API_KEY']; // Fetch API key from the environment

      final url = Uri.parse('https://api.api-ninjas.com/v1/quotes');
      final response = await http.get(
        url,
        headers: {'X-Api-Key': apiKey ?? ''},
      );

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        return Quote(text: json[0]['q'], author: json[0]['a']);
      } else {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quote: $e');
    }
  }
}
