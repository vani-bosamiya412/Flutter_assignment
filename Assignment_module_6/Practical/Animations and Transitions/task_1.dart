// Create a button that animates size and color on press using implicit animations.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedButtonExample(), debugShowCheckedModeBanner: false,));
}

class AnimatedButtonExample extends StatefulWidget {
  const AnimatedButtonExample({super.key});

  @override
  AnimatedButtonExampleState createState() => AnimatedButtonExampleState();
}

class AnimatedButtonExampleState extends State<AnimatedButtonExample> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isPressed = !_isPressed;
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isPressed ? 200 : 150,
            height: _isPressed ? 70 : 50,
            decoration: BoxDecoration(
              color: _isPressed ? Colors.blue : Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              "Press Me",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}