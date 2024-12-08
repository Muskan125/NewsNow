import 'package:flutter/material.dart';

import '../constants.dart/app_contants.dart';

class TitleCard  {
  Widget buildCustomCard(String subtitle, context) {
    return Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.hotRed,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'NN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NEWS NOW',
                    style: AppTextStyle.title.copyWith(
                      fontSize: 24,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.subtitle.copyWith(
                      fontSize: 12,
                      color: AppColors.grey.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}