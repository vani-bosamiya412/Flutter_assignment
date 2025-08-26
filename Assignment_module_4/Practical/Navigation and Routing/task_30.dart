// Build a basic profile page where the profile image is centered on the screen using Positioned inside a Stack, and other details (like name
// and bio) are displayed below.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ProfilePage(), debugShowCheckedModeBanner: false,));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.tealAccent
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.teal.shade100,
            width: double.infinity,
            height: double.infinity,
          ),
          Column(
            children: [
              SizedBox(height: 120,),
              SizedBox(height: 70,),
              Text("Vani Bosamiya", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Flutter Learner | Tech Enthusiast", style: TextStyle(fontSize: 16, color: Colors.black54), textAlign: TextAlign.center,),
            ],
          ),
          Positioned(
            top: 50,
            left: 50,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/1.jpg"),
              radius: 60,
              backgroundColor: Colors.white,
            )
          )
        ],
      ),
    );
  }
}
