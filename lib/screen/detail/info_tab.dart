import 'package:comics_app/component/cle_value_widget.dart';
import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  final List<Map<String, String>> cleValuePairs;

  const InfoTab({required this.cleValuePairs, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cleValuePairs == null || cleValuePairs!.isEmpty) {
      // Display message if data is null or empty
      return Center(
        child: Text(
          "Pas d'infos",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cleValuePairs.map((pair) {
          final cle = pair.keys.first;
          final text = pair.values.first;
          return Padding(
            padding:  EdgeInsets.only(top: 10.28),
            child: CleValueWidget(cle: cle, text: text),
          );
        }).toList(),
      );
  }
}
