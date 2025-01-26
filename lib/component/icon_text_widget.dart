import 'package:flutter/material.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;

  const IconTextRow({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 7.28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor ?? Colors.white,
          ),
          const SizedBox(width: 8.0),
          SizedBox(
            width: 162,
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
