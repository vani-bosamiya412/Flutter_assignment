// Create a "card" UI with a floating action button positioned at the bottom right using Stack and Positioned.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CardExample(), debugShowCheckedModeBanner: false,));
}

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card"),
        backgroundColor: Colors.purple.shade200,
      ),
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Container(
                width: 300,
                height: 180,
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Flutter UI Card", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    Text("This is a simple card with a floating action button placed at the bottom-right using Stack and Positioned.", style: TextStyle(fontSize: 14, color: Colors.black54),)
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: -20,
              child: FloatingActionButton(
                onPressed: () {  },
                backgroundColor: Colors.purple.shade200,
                child: Icon(Icons.add),
              )
            )
          ],
        ),
      ),
    );
  }
}
