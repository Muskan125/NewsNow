import 'package:flutter/material.dart';
import '../constants.dart/app_contants.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.2), 
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
              color: AppColors.hotRed,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.white,
                          size: 28,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'About',
                          style: AppTextStyle.title.copyWith(
                            color: AppColors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0, bottom: 10.0),
                      child: Text(
                        'Stay Informed, Stay Ahead',
                        style: AppTextStyle.subtitle.copyWith(
                          color: AppColors.white.withOpacity(0.8),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to NEWS NOW',
                style: AppTextStyle.title.copyWith(fontSize: screenWidth * 0.07),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Your one-stop destination for the latest and trending news from around the world.',
                style: AppTextStyle.subtitle.copyWith(fontSize: screenWidth * 0.045),
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Features',
                      style: AppTextStyle.title.copyWith(fontSize: screenWidth * 0.05),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      '• Access real-time updates from trusted news sources.\n'
                      '• Explore news across various categories.\n'
                      '• Save articles for offline reading.\n'
                      '• Personalize your feed for topics that interest you the most.',
                      style: AppTextStyle.body.copyWith(fontSize: screenWidth * 0.04),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.hotRed.withOpacity(0.1), AppColors.grey.withOpacity(0.1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.grey.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Our Vision',
                      style: AppTextStyle.title.copyWith(fontSize: screenWidth * 0.05),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      'At NEWS NOW, we aim to keep you informed, inspired, and connected with the world.',
                      style: AppTextStyle.body.copyWith(fontSize: screenWidth * 0.04),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
