// Build an image carousel that displays a different image every 3 seconds using PageView and an auto-slide feature.

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CarouselSliderExample(), debugShowCheckedModeBanner: false,));
}

class CarouselSliderExample extends StatefulWidget {
  const CarouselSliderExample({super.key});

  @override
  State<CarouselSliderExample> createState() => _CarouselSliderExampleState();
}

class _CarouselSliderExampleState extends State<CarouselSliderExample> {
  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "https://picsum.photos/id/1011/600/400",
      "https://picsum.photos/id/1015/600/400",
      "https://picsum.photos/id/1020/600/400",
      "https://picsum.photos/id/1025/600/400",
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Carousel Slider"),),
      body: Center(
        child: CarouselSlider(
          items: images.map((url) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
            );
          }).toList(),
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            aspectRatio: 16 / 9,
            initialPage: 0,
          ),
        ),
      ),
    );
  }
}
