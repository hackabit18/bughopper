import 'package:feel_safe/pages/homepage.dart';
import 'package:feel_safe/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

var user;
void main() async {
  user = await FirebaseAuth.instance.currentUser();
  print(user);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: (user == null)? Login(): HomePage(),
    );
  }
}