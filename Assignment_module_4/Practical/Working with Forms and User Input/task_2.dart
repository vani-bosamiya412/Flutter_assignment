// Design a registration form with validation for fields like name, email, phone number, and password.

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: RegistrationForm(), debugShowCheckedModeBanner: false,));
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
        backgroundColor: Colors.yellow.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder()
                  ),
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder()
                  ),
                  obscureText: true,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder()
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "Please enter your phone number";
                    }
                    if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                      return "Enter a valid 10-digit phone number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successful!")));
                      }
                    },
                    child: Text("Register", style: TextStyle(fontSize: 18),)
                )
              ],
            )
        ),
      ),
    );
  }
}
