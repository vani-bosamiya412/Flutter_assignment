// Develop a custom AvatarBadge widget that shows a user’s avatar with an optional online/offline status indicator.
// Create a profile screen layout using widgets such as Container, Column, Row, and Image.
// Build a list of cards displaying items in a product catalog (e.g., product name, price, and image).
// Design a custom button using a combination of Container, Padding, and Text widgets.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ProfileScreen44(), debugShowCheckedModeBanner: false,));
}

class AvatarBadge extends StatelessWidget {
  final String imageUrl;
  final bool isOnline;

  const AvatarBadge({super.key, required this.imageUrl ,required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage("assets/1.jpg"),
        ),
        Positioned(
          bottom: 4,
          top: 60,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2)
            ),
          )
        ),
      ],
    );
  }
}

class ProfileScreen44 extends StatelessWidget {
  ProfileScreen44({super.key});

  final List<Map<String, String>> products = [
    {"name": "Wireless Headphone", "price": "₹1,699", "image": "https://m.media-amazon.com/images/I/51FNnHjzhQL._UF1000,1000_QL80_.jpg"},
    {"name": "Smart Watch", "price": "₹1,449", "image": "https://www.boat-lifestyle.com/cdn/shop/files/Artboard_12_copy_3.png?v=1725944855"},
    {"name": "Sneakers", "price": "₹2,699 ", "image": "https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_600,h_600/global/395829/01/sv05/fnd/IND/fmt/png/Carina-Slim-Perf-Women's-Sneakers"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    AvatarBadge(imageUrl: 'assets/1.jpg', isOnline: true),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vani Bosamiya", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text("Flutter Learner", style: TextStyle(color: Colors.grey),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Column(
                children: products.map((product) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.network(product["image"]!),
                      title: Text(product["name"]!),
                      subtitle: Text("Price: ${product["price"]}"),
                    ),
                  );
                }).toList()
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Custom Button Pressed!")));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 4)
                    ],
                  ),
                  child: Text("Custom Button", style: TextStyle(color: Colors.white, fontSize: 16),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
