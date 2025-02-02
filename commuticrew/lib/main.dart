import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home.dart';
import 'screens/signin.dart';

void main() {
  runApp(MyApp()); // Ensure you have this function
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'CommutiCrew',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    final ButtonStyle filledButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.white; // Change to white when hovered
          }
          return Colors.blue; // Default filled color
        },
      ), foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.black; // Change to white when hovered
          }
          return Colors.white; // Default filled color
        },
      ),
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.blue), // Retain border
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ), 
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome to Commuti Crew!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue[900],
                fontWeight: FontWeight.bold,
                fontSize: 80,
              ),
            ),
          ), const SizedBox(height: 20), // Add some spacing
          Container(margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0), child: ElevatedButton(
            style: filledButtonStyle,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen())
              );
            },
            child: const Text('Sign In', style: TextStyle(fontSize: 45)),
          )),
          Container( margin: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 20.0, right: 20.0), child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return Colors.blue.withOpacity(0.44);
                  }
                  if (states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)) {
                    return Colors.blue.withOpacity(0.82);
                  }
                  return null; // Default behavior
                },
              ),
            ),
            onPressed: () {},
            child: const Text('Make an Account', style: TextStyle(fontSize: 35)),
          )),
          
        ],
      ),
    );
  }
}
