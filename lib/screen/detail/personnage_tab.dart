import 'package:comics_app/component/detail/character_widget.dart';
import 'package:flutter/material.dart';

class PersonnageTab extends StatelessWidget {
  final List<dynamic>? data;

  const PersonnageTab({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      // Display message if data is null or empty
      return Center(
        child: Text(
          "Pas de personnages",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final character = data?[index];
        if (character != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CharacterWidget(
              character_url: character['api_detail_url'] ?? "",
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
