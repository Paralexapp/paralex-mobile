import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../reusables/fonts.dart';
import '../reusables/paints.dart';
import '../routes/navs.dart';
import '../service_provider/view/widgets/black_button.dart';
import 'news_controller.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsController = Get.put(NewsController());

    return Scaffold(
      backgroundColor: PaintColors.bgColor,
      appBar: AppBar(
        backgroundColor: PaintColors.bgColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: BlackButton(
            containerColor: Colors.black,
            iconColor: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "News",
          style: FontStyles.smallCapsIntro.copyWith(
            fontSize: 16,
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000000),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("RefreshIndicator triggered!");
          await newsController.fetchLatestNews();
          await newsController.fetchCategorizedNews();
          print("Refresh completed");
        },
        child: Obx(() {
          final recentNews = newsController.latestNews.where((news) {
            final duration = DateTime.now().difference(news.publishedDate);
            return duration.inHours <= 24;
          }).toList();

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            children: [
              if (recentNews.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Latest News",
                    style: FontStyles.smallCapsIntro.copyWith(
                      fontSize: 16,
                      letterSpacing: 0,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4A4A68),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentNews.length,
                    itemBuilder: (context, index) {
                      final news = recentNews[index];
                      return Row(
                        children: [
                          NewsCard(
                            title: news.title,
                            category: news.section,
                            timestamp: DateFormat('HH:mm')
                                .format(news.publishedDate.toLocal()),
                            backgroundImage: news.imageUrl,
                            news: news,
                          ),
                          const SizedBox(width: 16),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
              TabBar(
                controller: newsController.tabController,
                tabs: newsController.tabs.map((tab) {
                  final isSelected = newsController.tabs.indexOf(tab) ==
                      newsController.selectedTabIndex.value;
                  return Tab(
                    child: Transform.translate(
                      offset: const Offset(-60, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? PaintColors.paralexpurple
                              : PaintColors.fadedPinkBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
                isScrollable: true,
                indicator: const BoxDecoration(color: Colors.transparent),
                dividerColor: Colors.transparent,
              ),
              SizedBox(
                height: 500,
                child: TabBarView(
                  controller: newsController.tabController,
                  children: newsController.tabs.map((tab) {
                    return Obx(() {
                      if (newsController.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: PaintColors.paralexpurple,
                          ),
                        );
                      }
                      final newsList = newsController.categorizedNews[tab] ?? [];
                      if (newsList.isEmpty) {
                        return Center(child: Text("No news available for $tab"));
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: newsList.length,
                        itemBuilder: (context, index) {
                          final news = newsList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: NewsCard(
                              title: news.title,
                              category: news.section,
                              timestamp: DateFormat('yyyy-MM-dd HH:mm')
                                  .format(news.publishedDate.toLocal()),
                              backgroundImage: news.imageUrl,
                              isFullWidth: true,
                              news: news,
                            ),
                          );
                        },
                      );
                    });
                  }).toList(),
                ),
              ),
            ],
          );
        }),
      ),

    );
  }
}

class NewsCard extends StatelessWidget {
  final News news;
  final String title;
  final String category;
  final String timestamp;
  final String? backgroundImage;
  final bool isFullWidth;

  const NewsCard({
    super.key,
    required this.title,
    required this.category,
    required this.timestamp,
    this.backgroundImage,
    this.isFullWidth = false,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Nav.detailedNewsScreen,arguments: news);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Stack(
          children: [
            Container(
              width: isFullWidth ? double.infinity : 250.0,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                  image: news.displayImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: isFullWidth ? double.infinity : 250.0,
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            Positioned(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        "Updated $timestamp",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

