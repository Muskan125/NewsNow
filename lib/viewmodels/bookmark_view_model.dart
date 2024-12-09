import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/article.dart';

class BookmarkViewModel extends ChangeNotifier {
  List<Article> _bookmarkedArticles = [];

  List<Article> get bookmarkedArticles => _bookmarkedArticles;

  BookmarkViewModel() {
    loadBookmarkedArticles();
  }

  Future<void> loadBookmarkedArticles() async {
    final prefs = await SharedPreferences.getInstance();
    final savedArticles = prefs.getStringList('bookmarkedArticles') ?? [];
    _bookmarkedArticles = savedArticles
        .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
        .toList();
    notifyListeners();
  }

  bool isBookmarked(Article article) {
    return _bookmarkedArticles.any((a) => a == article);
  }

  Future<void> toggleBookmark(Article article) async {
    final prefs = await SharedPreferences.getInstance();

    if (isBookmarked(article)) {
      _bookmarkedArticles.removeWhere((a) => a == article);
    } else {
      _bookmarkedArticles.add(article);
    }

    final savedArticles =
        _bookmarkedArticles.map((a) => jsonEncode(a.toJson())).toList();
    await prefs.setStringList('bookmarkedArticles', savedArticles);
    notifyListeners();
  }

  Future<void> clearAllBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    _bookmarkedArticles.clear();
    await prefs.remove('bookmarkedArticles');
    notifyListeners();
  }
}