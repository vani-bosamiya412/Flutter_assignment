// Create a loading animation for data fetching in an app.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoadingExample(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoadingExample extends StatefulWidget {
  const LoadingExample({super.key});

  @override
  LoadingExampleState createState() => LoadingExampleState();
}

class LoadingExampleState extends State<LoadingExample> {
  late Future<String> _dataFuture;

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return "Data fetched successfully!";
  }

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Loading Animation Example")),
      body: Center(
        child: FutureBuilder<String>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text("Fetching data..."),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Text(
                snapshot.data!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }
          },
        ),
      ),
    );
  }
}