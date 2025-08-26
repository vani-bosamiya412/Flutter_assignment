// Design a custom button with an icon positioned above the text. Use Stack to overlay the icon slightly on top of the text.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CustomButtonExample(), debugShowCheckedModeBanner: false,));
}

class CustomButtonExample extends StatelessWidget {
  const CustomButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Button With Stack"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Liked")));
          },
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal, width: 1.5),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 10,
                  child: Text("Like", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)
                ),
                Positioned(
                  top: 20,
                  child: Icon(Icons.favorite, size: 36, color: Colors.teal,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
