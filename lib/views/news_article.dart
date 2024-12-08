import 'package:flutter/material.dart';
import '../constants.dart/app_contants.dart';
import '../models/article.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.hotRed,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                article.source.name,
                style: AppTextStyle.title.copyWith(
                  color: AppColors.white, 
                  fontSize: 16,
                ),
              ),
              background: buildArticleImage(),
              titlePadding: const EdgeInsets.only(left: 50, bottom: 16),
            ),
            leading: IconButton(
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                buildArticleTitle(),
                const SizedBox(height: 8),
                buildAuthorInfo(),
                const SizedBox(height: 16),
                buildArticleDescription(),
                const SizedBox(height: 16),
                buildFullContent(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

Widget buildArticleImage() {
  return article.urlToImage != null && article.urlToImage!.isNotEmpty
      ? Image.network(
          article.urlToImage!,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: double.infinity,
              height: 250,
              color: AppColors.grey.withOpacity(0.2),
              child: const Center(
                child: Text(
                  'Couldn\'t load image',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          },
        )
      : Container(
          width: double.infinity,
          height: 250,
          color: AppColors.grey.withOpacity(0.2), 
          child: const Center(
            child: Text(
              'Image not available',
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 16,
              ),
            ),
          ),
        );
}

  Widget buildArticleTitle() {
    return Text(
      article.title ?? 'No title available',
      style: AppTextStyle.title.copyWith(
        fontSize: 24, 
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget buildAuthorInfo() {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.hotRed.withOpacity(0.2),
          child: Text(
            (article.author ?? 'U')[0].toUpperCase(),
            style: const TextStyle(
              color: AppColors.hotRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.author ?? 'Unknown',
                style: AppTextStyle.subtitle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                formatDate(article.publishedAt),
                style: AppTextStyle.subtitle.copyWith(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildArticleDescription() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        article.description ?? 'No description available.',
        style: AppTextStyle.body.copyWith(
          fontSize: 16,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildFullContent() {
    return Text(
      article.content ?? '',
      style: AppTextStyle.body.copyWith(
        fontSize: 16,
        height: 1.6,
      ),
      textAlign: TextAlign.left,
    );
  }

  String formatDate(DateTime date) {
    try {
      final months = [
        'January', 'February', 'March', 'April', 'May', 'June', 
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return 'Invalid Date';
    }
  }
}