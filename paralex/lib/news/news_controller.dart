import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final tabs = ["FINANCE", "CRIMINAL", "GOVERNMENT"];
  var selectedTabIndex = 0.obs;
  final isLoading = false.obs;
  var latestNews = <News>[].obs;
  var categorizedNews = <String, List<News>>{}.obs;
  @override
  void onInit() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
    fetchLatestNews();
    fetchCategorizedNews();
    super.onInit();
  }

  Future<void> fetchLatestNews() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('https://paralex-app-fddb148a81ad.herokuapp.com/api/news/get-all'));
      print("Response Body: ${response.body}");
      print("Response Type: ${response.body.runtimeType}");

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        latestNews.value = data.map((e) => News.fromJson(e)).toList();
      } else {
        print("Failed to fetch latest news. Status code: ${response.statusCode}");
        latestNews.value = [];
      }
    } catch (e) {
      print("Exception fetching latest news: $e");
    } finally{
      isLoading.value = false;
    }
  }

  Future<void> fetchCategorizedNews() async {
    isLoading.value = true;
    try {
      for (var category in tabs) {
        final url =
            'https://paralex-app-fddb148a81ad.herokuapp.com/api/news/get-by-section?section=$category';
        print("Fetching news for category: $category at $url");
        final response = await http.get(Uri.parse(url));
        print("Response for category $category: ${response.body}");

        if (response.statusCode == 200 && response.body.isNotEmpty) {
          final List<dynamic> data = jsonDecode(response.body);
          categorizedNews[category] = data.map((e) => News.fromJson(e)).toList();
        } else {
          print("Empty or invalid response for $category");
          categorizedNews[category] = [];
        }
      }
    } catch (e) {
      print("Exception fetching categorized news: $e");
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}

class News {
  final String id;
  final String section;
  final String title;
  final String content;
  final String publishedBy;
  final DateTime publishedDate;
  final String imageUrl;

  News({
    required this.id,
    required this.section,
    required this.title,
    required this.content,
    required this.publishedBy,
    required this.publishedDate,
    required this.imageUrl,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] ?? '',
      section: json['section'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      publishedBy: json['publishedBy'] ?? '',
      // Convert the date array to a DateTime object
      publishedDate: DateTime(
        json['publishedDate'][0],
        json['publishedDate'][1],
        json['publishedDate'][2],
        json['publishedDate'][3],
        json['publishedDate'][4],
        json['publishedDate'][5],
        json['publishedDate'][6] ~/ 1000000, // Microseconds part
      ),
      imageUrl: json['imageUrl'] ?? '',
    );
  }
  ImageProvider get displayImage {
    if (imageUrl.isNotEmpty && imageUrl != "string") {
      return NetworkImage(imageUrl);
    } else {
      return const AssetImage('assets/images/news_image.png');
    }
  }
}
