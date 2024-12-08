import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/new_service.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsApiService _newsApiService = NewsApiService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String? _error;

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Helper method to filter out invalid articles
  List<Article> notNullFilter(List<Article> articles) {
    return articles.where((article) =>
      article.title != null &&
      article.title != '[Removed]' &&
      article.title!.isNotEmpty &&
      article.description != null &&
      article.description != '[Removed]' &&
      article.description!.isNotEmpty
    ).toList();
  }

  /// Fetch apple articles 
  Future<void> fetchAppleArticles() async {
    _isLoading = true;
    _error = null;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });

    try {
      _articles = notNullFilter(await _newsApiService.fetchAppleNews());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    }
  }

  /// Fetch Tesla articles 
  Future<void> fetchTeslaArticles() async {
    _isLoading = true;
    _error = null;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });

    try {
      _articles = notNullFilter(await _newsApiService.fetchTeslaNews());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    }
  }

  /// Fetch Trump Articles
  Future<void> fetchTrumpArticles() async {
    _isLoading = true;
    _error = null;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });

    try {
      _articles = notNullFilter(await _newsApiService.fetchTrumpNews());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    }
  }

  /// Fetch top headlines
  Future<void> fetchTopHeadlines() async {
    _isLoading = true;
    _error = null;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });

    try {
      _articles = notNullFilter(await _newsApiService.fetchTopHeadlines());
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      Future.delayed(Duration.zero, () {
        notifyListeners();
      });
    }
  }
}