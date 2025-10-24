// Implement a news feed app that retrieves and displays articles from an API.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: NewsScreen(), debugShowCheckedModeBanner: false));
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    const String apiKey = 'e7d87a12e2294e39b80af802723ae6d8';
    const String url =
        'https://newsapi.org/v2/everything?q=india&apiKey=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        articles = data['articles'];
      });
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News Feed")),
      body: articles.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: article['urlToImage'] != null
                  ? Image.network(
                      article['urlToImage'],
                        width: 80,
                        fit: BoxFit.cover,
                      )
                  : Icon(Icons.image_not_supported),
                title: Text(article['title'] ?? 'No title'),
                subtitle: Text(article['description'] ?? 'No description'),
                onTap: () {
                  
                },
              ),
            );
          },
        ),
    );
  }
}