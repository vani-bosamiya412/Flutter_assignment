// Create a search app that fetches and displays movie information based on user input from an external API.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MovieSearchApp(),
  ));
}

class MovieSearchApp extends StatefulWidget {
  const MovieSearchApp({super.key});

  @override
  State<MovieSearchApp> createState() => _MovieSearchAppState();
}

class _MovieSearchAppState extends State<MovieSearchApp> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? movieData;
  bool isLoading = false;
  bool hasError = false;

  final String apiKey = "b1c22e89";

  Future<void> fetchMovie(String title) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    final url = "https://www.omdbapi.com/?t=$title&apikey=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['Response'] == "True") {
          setState(() {
            movieData = data;
            isLoading = false;
          });
        } else {
          setState(() {
            hasError = true;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie App"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter movie name",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_controller.text.trim().isNotEmpty) {
                      fetchMovie(_controller.text.trim());
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              CircularProgressIndicator()
            else if (hasError)
              Text(
                "Movie not found. Try another name.",
                style: TextStyle(color: Colors.red),
              )
            else if (movieData != null)
                Expanded(child: buildMovieCard())
              else
                 Text("Search for a movie"),
          ],
        ),
      ),
    );
  }

  Widget buildMovieCard() {
    return SingleChildScrollView(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (movieData!['Poster'] != "N/A")
                Image.network(movieData!['Poster'], height: 300),
              SizedBox(height: 12),
              Text(
                movieData!['Title'] ?? '',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text("Year: ${movieData!['Year']}"),
              Text("Genre: ${movieData!['Genre']}"),
              Text("Director: ${movieData!['Director']}"),
              SizedBox(height: 10),
              Text(
                "⭐ IMDb: ${movieData!['imdbRating']}",
                style: TextStyle(fontSize: 18, color: Colors.orange),
              ),
              Divider(),
              Text(
                movieData!['Plot'] ?? '',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}