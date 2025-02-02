import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'signin.dart';
import 'signup.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: EggScreen(),
//     );
//   }
// }

class EggScreen extends StatelessWidget {
  const EggScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
       // Set background color to white
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xfffbb7c0),
        ),
        child: Column (
         children: [ Align(
              alignment: Alignment.center,
              child: Text(
                "NEW DESTINATION REACHED!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color : Color(0xff4864D5),
                  fontWeight: FontWeight.bold,
                  fontSize: 64,
                ),
              ),
            ),
            const Image(image: AssetImage('assets/images/egg.png')),
            Align(
              alignment: Alignment.center,
              child: Text(
                "you discovered a blue spirited egg!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pangolin',
                  fontSize: 34,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "take public transit even futher to meet your new commute creature!",
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
