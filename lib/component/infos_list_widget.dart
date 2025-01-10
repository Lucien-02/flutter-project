import 'package:flutter/material.dart';
import 'infos_widget.dart';

// Exemple pour utiliser ce widget
// InfosListWidget(infosRows: [
//               const InfosRow(label: 'Name', text: 'Bao Huynh'),
//               const InfosRow(label: 'Age', text: '18'),
//               const InfosRow(label: 'City', text: 'Paris'),
//               const InfosRow(label: 'Country', text: 'France'),
//             ])
class InfosListWidget extends StatelessWidget {
  final List<InfosRow> infosRows;

  const InfosListWidget({
    super.key,
    required this.infosRows,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: infosRows.map((infosRow) => infosRow).toList(),
    );
  }
}
