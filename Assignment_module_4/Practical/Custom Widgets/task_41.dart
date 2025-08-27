// Create a custom RatingWidget that displays a series of stars and allows the user to select a rating from 1 to 5.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: RatingApp(), debugShowCheckedModeBanner: false,),);
}

class RatingApp extends StatefulWidget {
  const RatingApp({super.key});

  @override
  State<RatingApp> createState() => _RatingAppState();
}

class _RatingAppState extends State<RatingApp> {
  int rating = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Rating Widget"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingWidget (
              rating: rating,
              onRatingSelected: (value) {
                setState(() {
                  rating = value;
                });
              },
            ),
            SizedBox(height: 20,),
            Text("Selected Rating: $rating", style: TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final int rating;
  final ValueChanged<int> onRatingSelected;

  const RatingWidget({super.key, required this.rating, required this.onRatingSelected,});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return IconButton(
          onPressed: () {
            onRatingSelected(starIndex);
          },
          icon: Icon(starIndex <= rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 32,)
        );
      }),
    );
  }
}