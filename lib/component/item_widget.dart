import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String? subtitle;
  const ItemWidget({super.key, required this.imageUrl, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
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
                  ),)
                  
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}