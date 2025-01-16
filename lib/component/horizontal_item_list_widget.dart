import 'package:comics_app/component/item_widget.dart';
import 'package:comics_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HorizontalItemList extends StatelessWidget {
  final String title; 
  final List<Map<String, String>> items;
  final VoidCallback onVoirPlus; 

  const HorizontalItemList({
    super.key,
    required this.title,
    required this.items,
    required this.onVoirPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius:  BorderRadius.only(
          topLeft: Radius.circular(20), 
          bottomLeft: Radius.circular(20),
        ),
        color: AppColors.cardBackground,
      ),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom( 
                  fixedSize: const Size(92, 32)   ,              
                  backgroundColor: AppColors.backgroundScreen, 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), 
                  ),
                ),
                onPressed: onVoirPlus, 
                child: const Text(
                  'Voir plus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                    ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 242, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ItemWidget(
                  imageUrl: item['imageUrl'] ?? '',
                  title: item['title'] ?? '',
                  subtitle: item['subtitle'],
                ),
              );
            },
          ),
        ),
      ],
    ),
    );
     
  }
}