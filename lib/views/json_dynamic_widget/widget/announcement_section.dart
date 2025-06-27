import 'package:flutter/material.dart';
import 'package:main/utils/constant/colors.dart';
import 'package:hugeicons/hugeicons.dart';

class AnnouncementSection extends StatelessWidget {
  final bool showCategory;
  final String categoryType;
  final String? partnerId;
  AnnouncementSection({
    super.key,
    this.showCategory = false,
    this.categoryType = 'subCategory',
    this.partnerId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                'Announcement',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        HugeIcons.strokeRoundedFilterHorizontal,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // BlocBuilder<PublicServiceBloc, PublicServiceState>(
        //   builder: (context, state) {
        //     if (state.isLoading) {
        //       return const Center(child: CircularProgressIndicator());
        //     }

        //     if (state.error != null) {
        //       return Center(
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             state.error!,
        //             style: const TextStyle(color: Colors.red),
        //             textAlign: TextAlign.center,
        //             maxLines: 3,
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ),
        //       );
        //     }

        //     if (state.articles.isEmpty) {
        //       return const Center(child: Text('No articles found.'));
        //     }

        //     return Column(
        //       children: state.articles.map((article) {
        //         return Padding(
        //           padding: const EdgeInsets.only(bottom: 8.0),
        //           child: ArticleCard(
        //             title: article.title,
        //             mediaPath: article.mediaPath ?? '',
        //             source: article.source,
        //             categoryName: categoryType == 'category'
        //                 ? article.categoryName
        //                 : article.subCategoryName,
        //             categoryIconPath: categoryType == 'category'
        //                 ? article.categoryIconPath
        //                 : article.subCategoryIconPath,
        //             showCategory: showCategory,
        //             isVideo: article.isVideo,
        //             content: article.content,
        //             createdAt: article.createdAt,
        //           ),
        //         );
        //       }).toList(),
        //     );
        //   },
        // ),
      ],
    );
  }
}
