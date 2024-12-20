import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../constants.dart/app_contants.dart';
import '../views/news_article.dart';
import '../viewmodels/bookmark_view_model.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final bookmarkViewModel = Provider.of<BookmarkViewModel>(context);

    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      shadowColor: AppColors.grey.withOpacity(0.3),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleScreen(article: article),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildArticleImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      article.title ?? 'No title available',
                      style: AppTextStyle.title.copyWith(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      bookmarkViewModel.isBookmarked(article)
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: bookmarkViewModel.isBookmarked(article)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () => bookmarkViewModel.toggleBookmark(article),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

   Widget buildArticleImage() {
    return article.urlToImage != null && article.urlToImage!.isNotEmpty
        ? ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              article.urlToImage!,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  width: double.infinity,
                  color: AppColors.grey.withOpacity(0.2),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          size: 50,
                          color: AppColors.hotRed,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Couldn't load image",
                          style: AppTextStyle.subtitle.copyWith(
                            color: AppColors.hotRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Container(
            height: 200,
            width: double.infinity,
            color: AppColors.grey.withOpacity(0.2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 50,
                    color: AppColors.grey,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Image not available",
                    style: AppTextStyle.subtitle.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
