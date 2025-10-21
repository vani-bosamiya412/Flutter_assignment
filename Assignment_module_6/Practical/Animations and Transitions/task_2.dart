// Implement a Hero animation that transitions an image smoothly between two screens.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FirstScreen(), debugShowCheckedModeBanner: false,));
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Screen")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => SecondScreen()),);
          },
          child: Hero(
            tag: 'hero-image',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/morPankh.jpeg',
                width: 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Screen")),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FirstScreen()),);
          },
          child: Hero(
            tag: 'hero-image',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/morPankh.jpeg',
                width: 300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}