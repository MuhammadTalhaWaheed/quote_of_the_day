import 'package:flutter/material.dart';
import 'package:quote_of_the_day/quote_of_the_day.dart';

void main() {
  runApp(const MaterialApp(home: QuoteDemo()));
}

class QuoteDemo extends StatelessWidget {
  const QuoteDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: QuoteOfTheDayWidget(),
      ),
    );
  }
}
