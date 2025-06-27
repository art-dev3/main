import 'package:flutter/widgets.dart';

class CategoryLabel extends StatelessWidget {
  final String iconPath;
  final String name;

  const CategoryLabel({super.key, required this.iconPath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(iconPath, width: 20),
        const SizedBox(width: 4),
        Text(
          name,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xff1E293B),
          ),
        ),
      ],
    );
  }
}
