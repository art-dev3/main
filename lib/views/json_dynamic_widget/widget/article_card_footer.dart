import 'package:flutter/material.dart';
import 'package:main/utils/helper/time_ago.dart';

class ArticleCardFooter extends StatelessWidget {
  final String source;
  final DateTime createdAt;

  const ArticleCardFooter({
    super.key,
    required this.source,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          source,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xff1E40AF),
          ),
        ),
        Text(
          ' · ${timeAgo(createdAt)}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade400,
          ),
        ),
        const Spacer(),
        const _NewsMenu(),
      ],
    );
  }
}

class _NewsMenu extends StatelessWidget {
  const _NewsMenu();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, _) => GestureDetector(
        onTap: () => controller.isOpen ? controller.close() : controller.open(),
        child: const Text(
          '⋯',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
      menuChildren: [
        MenuItemButton(
          onPressed: () => print('Hide clicked'),
          child: const Text('Hide'),
        ),
        MenuItemButton(
          onPressed: () => print('Share clicked'),
          child: const Text('Share'),
        ),
      ],
    );
  }
}
