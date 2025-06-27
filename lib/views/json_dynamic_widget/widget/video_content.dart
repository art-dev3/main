import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoContent extends StatelessWidget {
  final VideoPlayerController? controller;
  final String title;
  final bool isPlaying;
  final VoidCallback onTap;

  const VideoContent({
    super.key,
    required this.controller,
    required this.title,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xff1E293B),
          ),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                controller != null && controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: controller!.value.aspectRatio,
                        child: VideoPlayer(controller!),
                      )
                    : Container(
                        height: 180,
                        color: Colors.black12,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                if (!isPlaying)
                  const Icon(
                    Icons.play_circle_fill,
                    size: 50,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
