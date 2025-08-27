// Create a custom ProfileCard widget that takes name, image, and bio as properties and displays them in a nicely styled card.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Profile(), debugShowCheckedModeBanner: false,));
}
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Profile Card"),
            backgroundColor: Colors.pink.shade50
        ),
        body: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("assets/1.jpg"),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Vani Bosamiya", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                          Text("Flutter Learner", style: TextStyle(fontSize: 16, color: Colors.grey.shade600),),
                          SizedBox(height: 5),
                          Text("A passionate Flutter developer who loves building beautiful and responsive apps. Always curious to learn more and grow every day.", style: TextStyle(fontSize: 16, color: Colors.grey[800]),)
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}