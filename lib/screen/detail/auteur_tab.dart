import 'package:comics_app/component/detail/character_widget.dart';
import 'package:comics_app/component/detail/person_widget.dart';
import 'package:flutter/material.dart';

class AuteurTab extends StatelessWidget {
  final List<dynamic>? data;

  const AuteurTab({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      // Display message if data is null or empty
      return Center(
        child: Text(
          "Pas d'auteurs",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final person = data?[index];
        if (person != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PersonWidget(
              person_url: person['api_detail_url'] ?? "",
              role: person['role'] ?? "",
            ),
          );
        } else {
          return Center(
            child: Text(
              'Error: Pas de personnage',
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          );
        }
      },
    );
  }
}
