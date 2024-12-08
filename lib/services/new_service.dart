import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/article.dart';

class NewsApiService {
  final String apiKey = dotenv.env['apiKey'] ?? '';
  final String baseUrl = dotenv.env['baseUrl'] ?? '';

  Future<List<Article>> fetchAppleNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl/everything?q=apple&from=2024-12-06&to=2024-12-06&sortBy=popularity&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
// fetch Tesla news
    Future<List<Article>> fetchTeslaNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl/everything?q=tesla&from=2024-11-08&sortBy=publishedAt&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }

  // fetch Trump news
    Future<List<Article>> fetchTrumpNews() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?q=trump&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load news');
    }
  }
  /// Fetch top headlines (US-based)
  Future<List<Article>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&category=business&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Article> articles = (data['articles'] as List)
          .map((articleJson) => Article.fromJson(articleJson))
          .toList();
      return articles;
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}