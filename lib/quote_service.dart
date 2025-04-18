import 'dart:convert';
import 'package:http/http.dart' as http;
import 'quote_model.dart';

class QuoteService {
  static Future<Quote> fetchRandomQuote() async {
    try {
      final url = Uri.parse('https://api.api-ninjas.com/v1/quotes');
      final response = await http.get(
        url,
        headers: {'X-Api-Key': 'Enter your key'}
      );

      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        return Quote(text: json[0]['quote'], author: json[0]['author']);
      } else {
        throw Exception('Failed to load quote: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching quote: $e');
    }
  }
}
