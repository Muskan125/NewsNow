import 'package:flutter/material.dart';
import 'package:newsnow/viewmodels/news_view_model.dart';
import 'package:provider/provider.dart';
import '../constants.dart/app_contants.dart';
import '../widgets/article_card.dart';
import '../widgets/title_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    newsViewModel.fetchTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context);
    
  final filteredArticles = newsViewModel.articles.where((article) {
  return article.title != null && 
         article.title!.toLowerCase().contains(searchQuery.toLowerCase());
}).toList();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Header(),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search news...',
                hintStyle: AppTextStyle.subtitle,
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                suffixIcon: searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppColors.grey),
                        onPressed: () {
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.grey.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              searchQuery.isNotEmpty
                  ? 'Search Results (${filteredArticles.length})'
                  : 'Top Headlines',
              style: AppTextStyle.subtitle.copyWith(
                color: AppColors.hotRed,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: newsViewModel.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.hotRed),
                    ),
                  )
                : filteredArticles.isEmpty
                    ? const Center(
                        child: Text(
                          'No articles found',
                          style: TextStyle(color: AppColors.grey),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = filteredArticles[index];
                          return ArticleCard(article: article);
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleCard().buildCustomCard("Your Daily Digest", context),
          Container(
            decoration: BoxDecoration(
              color: AppColors.hotRed.withOpacity(0.03),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.hotRed,
                  size: 28,
                ),
                onPressed: () {
                  newsViewModel.fetchTopHeadlines();
                },
                tooltip: 'Refresh News',
                splashColor: AppColors.hotRed.withOpacity(0.2),
                highlightColor: AppColors.hotRed.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}