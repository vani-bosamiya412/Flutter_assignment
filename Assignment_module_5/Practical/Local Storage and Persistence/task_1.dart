// Create an app that uses shared_preferences to store and display user preferences.

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: SharedPreferenceEx(), debugShowCheckedModeBanner: false,));
}

class SharedPreferenceEx extends StatefulWidget {
  const SharedPreferenceEx({super.key});

  @override
  State<SharedPreferenceEx> createState() => _SharedPreferenceExState();
}

class _SharedPreferenceExState extends State<SharedPreferenceEx> {
  final TextEditingController _controller = TextEditingController();
  late String _savedName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadName();
  }

  Future _loadName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedName = prefs.getString("username") ?? "";
    });
  }

  Future _saveName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", _controller.text);

    setState(() {
      _savedName = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter your name: ", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Type your name here..."
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _saveName,
              child: Text("Save"),
            ),
            SizedBox(height: 20,),
            Text("Saved Name: $_savedName", style: TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}
