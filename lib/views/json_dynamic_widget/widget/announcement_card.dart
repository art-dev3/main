import 'package:flutter/material.dart';
import 'package:main/views/json_dynamic_widget/widget/article_card_footer.dart';
import 'package:main/views/json_dynamic_widget/widget/category_label.dart';
import 'package:main/views/json_dynamic_widget/widget/image_content.dart';
import 'package:main/views/json_dynamic_widget/widget/video_content.dart';
import 'package:video_player/video_player.dart';

class ArticleCard extends StatefulWidget {
  final String title;
  final String mediaPath;
  final String source;
  final bool isVideo;
  final bool showCategory;
  final String categoryName;
  final String categoryIconPath;
  final String content;
  final DateTime createdAt;

  const ArticleCard({
    super.key,
    required this.title,
    required this.mediaPath,
    required this.source,
    required this.categoryName,
    required this.categoryIconPath,
    required this.content,
    required this.createdAt,
    this.isVideo = false,
    this.showCategory = true,
  });

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.isVideo) {
      _controller = VideoPlayerController.contentUri(
        Uri.parse(widget.mediaPath),
      )..initialize().then((_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_controller != null) {
      setState(() {
        _isPlaying = !_controller!.value.isPlaying;
        _isPlaying ? _controller!.play() : _controller!.pause();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showCategory)
            CategoryLabel(
              iconPath: widget.categoryIconPath,
              name: widget.categoryName,
            ),
          const SizedBox(height: 8),
          widget.isVideo
              ? VideoContent(
                  controller: _controller,
                  title: widget.title,
                  isPlaying: _isPlaying,
                  onTap: _togglePlay,
                )
              : ImageContent(title: widget.title, imagePath: widget.mediaPath),
          const SizedBox(height: 11),
          ArticleCardFooter(source: widget.source, createdAt: widget.createdAt),
        ],
      ),
    );
  }
}
