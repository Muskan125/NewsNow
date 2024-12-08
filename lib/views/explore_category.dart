import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart/app_contants.dart';
import '../viewmodels/news_view_model.dart';
import '../widgets/article_card.dart';
import '../widgets/title_card.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int selectedCategoryIndex = 0;
  late PageController pageController;

  final List<String> categories = [
    'About Apple',
    'About Tesla',
    'About Trump',
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedCategoryIndex);
    _fetchCategoryArticles(selectedCategoryIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _fetchCategoryArticles(int index) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    switch (index) {
      case 0:
        newsViewModel.fetchAppleArticles();
        break;
      case 1:
        newsViewModel.fetchTeslaArticles();
        break;
      case 2:
        newsViewModel.fetchTrumpArticles();
        break;
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _fetchCategoryArticles(index);
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Padding(
             padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: TitleCard().buildCustomCard("Explore Categories", context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal:5),
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => _onCategorySelected(index),
                      child: CategoryCard(
                        category: categories[index],
                        isSelected: selectedCategoryIndex == index,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                  _fetchCategoryArticles(index);
                },
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  if (newsViewModel.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.hotRed),
                      ),
                    );
                  } else if (newsViewModel.error != null) {
                    return Center(
                      child: Text(
                        'Error fetching articles',
                        style: AppTextStyle.subtitle,
                      ),
                    );
                  } else if (newsViewModel.articles.isEmpty) {
                    return Center(
                      child: Text(
                        'No articles found',
                        style: AppTextStyle.subtitle,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true, 
                      itemCount: newsViewModel.articles.length,
                      itemBuilder: (context, articleIndex) {
                        final article = newsViewModel.articles[articleIndex];
                        return ArticleCard(article: article);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final bool isSelected;

  const CategoryCard({super.key, required this.category, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.hotRed : AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.hotRed : AppColors.grey.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
