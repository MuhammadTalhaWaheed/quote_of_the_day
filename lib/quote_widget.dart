import 'package:flutter/material.dart';
import 'quote_model.dart';
import 'quote_service.dart';

class QuoteOfTheDayWidget extends StatefulWidget {
  final BoxDecoration? decoration;
  final TextStyle? textStyle;
  final TextStyle? authorStyle;

  const QuoteOfTheDayWidget({
    super.key,
    this.decoration,
    this.textStyle,
    this.authorStyle,
  });

  @override
  State<QuoteOfTheDayWidget> createState() => _QuoteOfTheDayWidgetState();
}

class _QuoteOfTheDayWidgetState extends State<QuoteOfTheDayWidget> {
  late Future<Quote> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = QuoteService.fetchRandomQuote();
  }

  void _refreshQuote() {
    setState(() {
      _quoteFuture = QuoteService.fetchRandomQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quote>(
      future: _quoteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Failed to load quote.');
        } else if (snapshot.hasData) {
          final quote = snapshot.data!;
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: widget.decoration ??
                BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.purple],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '"${quote.text}"',
                  style: widget.textStyle ??
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '- ${quote.author}',
                  style: widget.authorStyle ??
                      const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _refreshQuote,
                  child: const Text("New Quote"),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
