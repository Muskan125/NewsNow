import 'package:flutter/material.dart';
import '../constants.dart/app_contants.dart'; 

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white, 
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), 
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        onTap: widget.onTap,
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColors.hotRed,
        unselectedItemColor: AppColors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 26, 
        selectedFontSize: 12, 
        unselectedFontSize: 12,
        elevation: 0,
        items: [
          _buildNavItem(Icons.home, 'Home', 0),
          _buildNavItem(Icons.article, 'Explore', 1),
          _buildNavItem(Icons.bookmark, 'Bookmark', 2),
          _buildNavItem(Icons.account_circle, 'About', 3),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: _buildNavBarIcon(icon, index),
      label: label,
    );
  }
  Widget _buildNavBarIcon(IconData icon, int index) {
    bool isSelected = widget.selectedIndex == index;
    return AnimatedScale(
      scale: isSelected ? 1.1 : 1.0, 
      duration: const Duration(milliseconds: 250), 
      child: Icon(
        icon,
        color: isSelected ? AppColors.hotRed : AppColors.grey,
        size: 26, 
      ),
    );
  }
}
