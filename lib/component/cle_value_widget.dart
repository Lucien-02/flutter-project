import 'package:flutter/material.dart';

class CleValueWidget extends StatelessWidget {
  final String cle;
  final String text;

  const CleValueWidget({
    super.key,
    required this.cle,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final dataList = text.split(", ") ?? [];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              cle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8.0),

          Expanded(
            flex: 1,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dataList.map((data) {
                return Text(
                  data,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
