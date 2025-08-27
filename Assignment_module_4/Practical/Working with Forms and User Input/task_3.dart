// Implement a feedback form that includes dropdowns, checkboxes, and text input fields, with submission handling.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: FeedbackForm(), debugShowCheckedModeBanner: false,));
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  String? _selectedCategory;
  final List<String> _categories = ["Bug Report", "Suggestion", "Compliment"];

  bool receiveUpdates = false;
  bool contactUs = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Feedback Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _commentsController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Comments",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text("Select Feedback Category"),
              items: _categories.map((String category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            CheckboxListTile(
              value: receiveUpdates,
              title: Text("Receive Updates"),
              onChanged: (value) {
                setState(() {
                  receiveUpdates = value ?? false;
                });
              }
            ),
            SizedBox(height: 20,),
            CheckboxListTile(
              value: contactUs,
              title: Text("Contact Us"),
              onChanged: (value) {
                setState(() {
                  contactUs = value ?? false;
                });
              }
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_nameController.text.isEmpty ||
                      _commentsController.text.isEmpty ||
                      _selectedCategory == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields")),);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Thank you ${_nameController.text}! Your feedback (${_selectedCategory!}) has been submitted.",
                        ),
                      ),
                    );
                  }
                },
                child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}