import 'package:comics_app/component/icon_text_widget.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    final TextTheme textTheme = Theme.of(context).textTheme;

    return InkWell(
        onTap: () {
          Widget targetScreen;
          String route_name;
          Object params;
          switch (type) {
            case 'serie':
              route_name = '/serie-detail';
              params = { "title":name,"imageUrl":imageUrl,"url":url,"id":id};
              break;
            case 'comic':
              route_name = '/comic-detail';
              params = { "title":name,"imageUrl":imageUrl,"url":url,"id":id};
              break;
            case 'movie':
              route_name = '/serie-detail';
              params = { "title":name,"imageUrl":imageUrl,"url":url,"id":id};
              break;
            default:
              route_name = '/serie-detail';
              params = { "title":name,"imageUrl":imageUrl,"url":url,"id":id};
          }
          GoRouter.of(context).push(route_name,extra: params);
        },
        child:Card(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 359,
              height: 200,
              child: Row(
                children: [
                  // Left Image with rank badge
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageUrl.isNotEmpty ? imageUrl : "https://comicvine.gamespot.com/a/uploads/scale_avatar/6/67663/6238345-3060875932-35677.jpg",
                          width: 129,
                          height: 133,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 5,
                        left: 5,
                        child:ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            height: 40.49,
                            width: 59.36,
                            color: Colors.orange,
                            alignment: Alignment.center,
                            child: Text(
                              '#$rank',
                              style: textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  // Text Content
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(top: 15.0),
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
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4),
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
                        )
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}