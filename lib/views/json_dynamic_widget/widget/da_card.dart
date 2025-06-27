import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DaCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color textColor;
  final String buttonText;
  final VoidCallback? onTap;
  final String? backGroundImageUrl;
  final Color overlayColor;
  final String overlayImageUrl;
  final int overlayImageUrlHeight;
  final int overlayImageUrlWidth;

  const DaCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.textColor = Colors.white,
    required this.buttonText,
    this.onTap,
    this.backGroundImageUrl,
    this.overlayColor = const Color(0xCC9F0712),
    required this.overlayImageUrl,
    this.overlayImageUrlHeight = 171,
    this.overlayImageUrlWidth = 179,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 171,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: backGroundImageUrl!,
              fit: BoxFit.cover,
            ),
            Container(color: overlayColor),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 219,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 141,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          buttonText,
                          style: TextStyle(
                            color: const Color(0xFF1E293B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: overlayImageUrlHeight.toDouble(),
                width: overlayImageUrlWidth.toDouble(),
                child: CachedNetworkImage(
                  imageUrl: overlayImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
