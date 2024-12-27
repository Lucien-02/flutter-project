import 'package:comics_app/component/icon_text_widget.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EpisodeWidget extends StatelessWidget {
  final int id;
  final String name;
  final String subtitle;
  final List<Map<IconData, String>> keyValuePairs;
  final String imageUrl;

  const EpisodeWidget({
    Key? key,
    required this.id,
    required this.name,
    required this.subtitle,
    required this.keyValuePairs,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Card(
      color: AppColors.cardElementBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 344,
          height: 129,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 11, bottom: 13, left: 13),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    imageUrl.isNotEmpty
                        ? imageUrl
                        : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                    width: 126,
                    height: 105,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 11),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        name,
                        style: textTheme.headlineMedium,
                      ),
                      // Subtitle
                      Text(
                        subtitle,
                        style: textTheme.labelMedium,
                      ),
                      SizedBox(height: 10),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
