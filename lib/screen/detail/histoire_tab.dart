import 'package:comics_app/component/detail/history_widget.dart';
import 'package:flutter/material.dart';

class HistoireTab extends StatelessWidget {
  final String data;

  const HistoireTab({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data!.isEmpty) {
      // Display message if data is null or empty
      return Center(
        child: Text(
          "Pas d'histoire",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }
    return HistoryWidget(history:data);
  }
}