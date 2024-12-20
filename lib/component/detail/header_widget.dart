import 'package:comics_app/component/icon_text_widget.dart';
import 'package:flutter/material.dart';



class HeaderWidget extends StatelessWidget {
  final List<Map<IconData, String>> keyValuePairs;
  final String imageUrl;

  const HeaderWidget({
    super.key,
    required this.keyValuePairs,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Ensure proper vertical alignment
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl.isNotEmpty
                    ? imageUrl
                    : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                width: 95,
                height: 127,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: keyValuePairs.map((pair) {
                  final icon = pair.keys.first;
                  final text = pair.values.first;
                  return Padding(
                    padding:  EdgeInsets.symmetric(vertical: 4.0),
                    child: IconTextRow(icon: icon, text: text),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}