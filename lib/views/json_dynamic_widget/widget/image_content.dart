import 'package:flutter/material.dart';

class ImageContent extends StatelessWidget {
  final String title;
  final String imagePath;

  const ImageContent({super.key, required this.title, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xff1E293B),
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imagePath,
            width: MediaQuery.of(context).size.width * 0.4,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
