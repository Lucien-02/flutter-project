import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


class HistoryWidget extends StatelessWidget {

  final String history;

  const HistoryWidget({
    super.key,
    required this.history,
  });

  String _preprocessHtml(String content) {
    // Remove all <figure> tags and their content
    final figureRegEx = RegExp(r'<figure[^>]*>.*?<\/figure>', dotAll: true);
    return content.replaceAll(figureRegEx, '');
  }

  @override
  Widget build(BuildContext context) {
    final processedHtml = _preprocessHtml(history);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Html(
          data: processedHtml,
          style: {
            "*": Style(color: Colors.white)
          },
        ),
      ),
    );
  }
}