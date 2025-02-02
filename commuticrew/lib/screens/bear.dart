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
      home: BearScreen(),
    );
  }
}

class BearScreen extends StatelessWidget {
  const BearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
       // Set background color to white
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color : Color(0xff4864D5),
        ),
        child: Column (
         children: [ Align(
              alignment: Alignment.center,
              child: Text(
                "MEET JOE THE BRUIN BEAR!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pangolin',
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                  color : Color(0xffffffff),
                ),
              ),
            ),
            const Image(image: AssetImage('assets/images/joe.png')),
          
            Align(
              alignment: Alignment.center,
              child: Text(
                "Joe will accompany you along with Traveler and the rest of your CommutiCrew! Keep traveling around Los Angeles and beyond to unlock more friends!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // fontFamily: 'Pangolin',
                  fontSize: 29,
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
