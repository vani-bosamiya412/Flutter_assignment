// Use a Stack widget to create an overlay effect, where a centered image has a partially transparent overlay with some text.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: OverlayExample(), debugShowCheckedModeBanner: false,));
}

class OverlayExample extends StatelessWidget {
  const OverlayExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network("https://images.unsplash.com/photo-1507525428034-b723cf961d3e", width: double.infinity, height: double.infinity, fit: BoxFit.cover,),
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              width: double.infinity,
              height: double.infinity,
            ),
            Text("Hello Everyone!", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
