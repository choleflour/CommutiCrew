import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home.dart';
import 'screens/signin.dart';
import 'screens/signup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import "package:path/path.dart" show dirname, join;
import 'dart:io' show Platform;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signOut();
  try {
    
    // String fn = join(dirname(Platform.script.path), '../.env');
    // print(fn);
    

    await dotenv.load(fileName: '/Users/chloechang/CommutiCrew/commuticrew/.env');
  } catch (e) {
    print("Error loading .env file: $e");
  }
  // initializeGoogleMaps();
  runApp(const MyApp());
}


// void initializeGoogleMaps() {
//   String apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
//   if (apiKey.isNotEmpty) {
//     GMSServices.provideAPIKey(apiKey);
//   } else {
//     throw Exception("Google Maps API Key not found in .env");
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const NavigationScreen();
        },
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/signin': (context) => SigninScreen(),
        '/signup': (context) => SignupScreen(),
      },
      title: 'CommutiCrew',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle filledButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.white;
          }
          return Colors.blue;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.black;
          }
          return Colors.white;
        },
      ),
      side: MaterialStateProperty.all(
        const BorderSide(color: Colors.blue),
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
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
            child: ElevatedButton(
              style: filledButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, '/signin');
              },
              child: const Text('Sign In', style: TextStyle(fontSize: 45)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 40.0, bottom: 20.0, left: 20.0, right: 20.0),
            child: TextButton(
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
                    return null;
                  },
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child:
                  const Text('Make an Account', style: TextStyle(fontSize: 35)),
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
        ],
      ),
    );
  }
}