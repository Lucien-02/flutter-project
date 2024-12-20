import 'package:comics_app/component/icon_text_widget.dart';
import 'package:comics_app/screen/detail_serie_screen.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final int id;
  final String name;
  final String subtitle;
  final List<Map<IconData, String>> keyValuePairs;
  final String imageUrl;
  final int rank;
  final String url;
  final String type;

  const CardWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.subtitle,
    required this.keyValuePairs,
    required this.imageUrl,
    required this.rank,
    required this.url,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Widget targetScreen;
          switch (type) {
            case 'serie':
              targetScreen = DetailSerieScreen(
                title: name,
                imageUrl: imageUrl,
                url: url,
                id:id,
              );
              break;
            case 'comic':
              targetScreen = DetailSerieScreen(
                title: name,
                imageUrl: imageUrl,
                url: url,
                id:id,
              );
              break;
            case 'movie':
              targetScreen = DetailSerieScreen(
                title: name,
                imageUrl: imageUrl,
                url: url,
                id:id,
              );
              break;
            default:
              targetScreen = DetailSerieScreen(
                title: name,
                imageUrl: imageUrl,
                url: url,
                id:id,
              );
          }

          // Navigate to the appropriate screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => targetScreen,
            ),
          );
        },
    child:Card(
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Left Image with rank badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl.isNotEmpty ? imageUrl : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                    width: 80,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.orange,
                    child: Text(
                      '#$rank',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // Subtitle
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Key-Value pairs
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: keyValuePairs.map((pair) {
                      final icon = pair.keys.first;
                      final text = pair.values.first;
                      return Row(
                        children: [
                          IconTextRow(icon: icon, text: text),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}