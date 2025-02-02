import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'signin.dart';
import 'signup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlankScreen(),
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
       // Set background color to white
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 254, 182),
        ),
        child: Column (
         children: [ Align(
              alignment: Alignment.center,
              child: Text(
                "Who's in your current crew?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color : Color(0xffd7263d),
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                  fontFamily: 'Pangolin',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('Go to Map'),
              ),
            ),
        ]))
    );
  }
}
