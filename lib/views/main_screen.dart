import 'package:flutter/material.dart';
import 'package:newsnow/views/bookmark.dart';
import '../widgets/bottom_nav.dart';
import 'home_screen.dart'; 
import 'about.dart'; 
import 'explore_category.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(), 
    const Category(), 
    const Bookmark(),
    const About(), 
  ];

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[selectedIndex], 
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onTap: onTapped, 
      ),
    );
  }
}
