import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart/app_contants.dart';
import '../viewmodels/bookmark_view_model.dart';
import '../widgets/article_card.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    final bookmarkViewModel = Provider.of<BookmarkViewModel>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: AppColors.hotRed,
          elevation: 0,
          title: Text(
            'Bookmarks',
            style: AppTextStyle.title.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.white
            ),
          ),
          actions: [
            PopupMenuButton<String>(
              icon:const Icon(
                Icons.more_vert,
                color: AppColors.white,
              ),
              onSelected: (value) {
                if (value == 'clear_all') {
                  _showClearAllDialog(context, bookmarkViewModel);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'clear_all',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.delete_sweep,
                        color: AppColors.hotRed,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Clear All Bookmarks',
                        style: AppTextStyle.body.copyWith(
                          color: AppColors.hotRed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: bookmarkViewModel.bookmarkedArticles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    size: 100,
                    color: AppColors.grey.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No bookmarks yet',
                    style: AppTextStyle.subtitle.copyWith(
                      fontSize: 18,
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    'Save articles to read later',
                    style: AppTextStyle.body.copyWith(
                      color: AppColors.grey.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: bookmarkViewModel.bookmarkedArticles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(
                    article: bookmarkViewModel.bookmarkedArticles[index],
                  );
                },
              ),
            ),
    );
  }

  void _showClearAllDialog(
      BuildContext context, BookmarkViewModel bookmarkViewModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Clear All Bookmarks',
            style: AppTextStyle.title.copyWith(fontSize: 20),
          ),
          content: Text(
            'Are you sure you want to remove all bookmarked articles?',
            style: AppTextStyle.body,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: AppTextStyle.body.copyWith(color: AppColors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.hotRed,
              ),
              child: Text(
                'Clear All',
                style: AppTextStyle.buttonText,
              ),
              onPressed: () {
                bookmarkViewModel.clearAllBookmarks();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}