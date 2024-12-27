import 'package:comics_app/component/detail/person_widget.dart';
import 'package:flutter/material.dart';

class PersonnageTab extends StatelessWidget {
  final List<dynamic>? data;

  const PersonnageTab({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        final character = data?[index];
        if (character != null) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PersonWidget(
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
