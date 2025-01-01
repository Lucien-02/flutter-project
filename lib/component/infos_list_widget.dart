import 'package:comics_app/component/infos_widget.dart';
import 'package:flutter/material.dart';

class InfosListWidget extends StatelessWidget {
  final List<InfosRow> infos;

  const InfosListWidget({
    super.key,
    required this.infos,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: infos,
      ),
    );
  }
}
