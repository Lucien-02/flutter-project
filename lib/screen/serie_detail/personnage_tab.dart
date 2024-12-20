import 'package:flutter/material.dart';

class PersonnageTab extends StatelessWidget {
  final String data;

  const PersonnageTab({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Text(data, style: const TextStyle(color: Colors.white)),
    );
  }
}