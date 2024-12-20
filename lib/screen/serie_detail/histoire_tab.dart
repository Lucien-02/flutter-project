import 'package:comics_app/component/detail/history_widget.dart';
import 'package:flutter/material.dart';

class HistoireTab extends StatelessWidget {
  final String data;

  const HistoireTab({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HistoryWidget(history:data);
  }
}