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
      home: CrewScreen(),
    );
  }
}

class CrewScreen extends StatelessWidget {
  const CrewScreen({super.key});

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
         children: [ Container(
              // alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 80.0),
              child: Text(
                "Who's in your current crew?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color : Color(0xffd7263d),
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  fontFamily: 'Pangolin',
                ),
              ),
            ),
            const Image(image: AssetImage('assets/images/traveler.png')),
            Text(
                'This is Traveler the Horse! You met him at USC on February 1st, 2025. Traveler has traveled 13 miles with you on public transit so far! He is so excited to go on even more adventures and his daily travel tip today is "USC students can register for their own UPass and travel around Los Angeles on public transit for free!',
                textAlign: TextAlign.center,
                style: TextStyle(
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
