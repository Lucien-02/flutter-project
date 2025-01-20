import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  final String url;
  final String type;
  final int id;
  const ItemWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      this.subtitle,
      required this.id,
      required this.type,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Widget targetScreen;
        String route_name;
        Object params;
        switch (type) {
          case 'serie':
            route_name = '/serie-detail';
            params = {
              "title": title,
              "imageUrl": imageUrl,
              "url": url,
              "id": id
            };
            break;
          case 'comic':
            route_name = '/comic-detail';
            params = {
              "title": title,
              "imageUrl": imageUrl,
              "url": url,
              "id": id
            };
            break;
          case 'film':
            route_name = '/film-detail';
            params = {
              "title": title,
              "imageUrl": imageUrl,
              "url": url,
              "id": id
            };
            break;
          default:
            route_name = '/serie-detail';
            params = {
              "title": title,
              "imageUrl": imageUrl,
              "url": url,
              "id": id
            };
        }
        GoRouter.of(context).push(route_name, extra: params);
      },
      child: Container(
        width: 180,
        height: 242,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.cardElementBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                imageUrl,
                width: 180,
                height: 177,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 180,
                    height: 177,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  );
                },
              ),
            ),
            // Title and Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Subtitle (affiché uniquement si présent)
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    SizedBox(
                      width: 180,
                      child: Text(
                        subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
