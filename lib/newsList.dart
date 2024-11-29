import 'package:flutter/material.dart';
import 'package:news_app/api/api_services.dart';
import 'package:news_app/models/newsModel.dart';
import 'package:news_app/news_card.dart';
import 'dart:async'; // Import for Timer

class NewsList extends StatefulWidget {
  const NewsList({super.key, required this.sourceID});
  final String sourceID;

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  TextEditingController searchController = TextEditingController();
  List<Articles> allNewsList = [];
  List<Articles> filteredNewsList = [];
  Timer? _debounce; // Timer for debouncing search input

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel(); // Cancel the debounce timer when disposing
    super.dispose();
  }

  // Debounced search handler
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      _filterNews(searchController.text);
    });
  }

  // Method to filter the news list based on the search query
  void _filterNews(String query) {
    String lowerCaseQuery = query.toLowerCase();
    setState(() {
      filteredNewsList = allNewsList
          .where((article) =>
              article.title!.toLowerCase().contains(lowerCaseQuery) ||
              article.description!.toLowerCase().contains(lowerCaseQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
      future: ApiServices.getNews(widget.sourceID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error.toString()}"));
        }

        NewsModel? newsModel = snapshot.data;
        var newsList = newsModel?.articles ?? [];

        // Initialize the allNewsList and filteredNewsList once
        if (allNewsList.isEmpty) {
          allNewsList = newsList;
          filteredNewsList = newsList; // Initially show all news
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search news...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: filteredNewsList.length,
              itemBuilder: (context, index) {
                return NewsCard(newsModel: filteredNewsList[index]);
              },
            ),
          ],
        );
      },
    );
  }
}
