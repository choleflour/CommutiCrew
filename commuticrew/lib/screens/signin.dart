import 'package:flutter/material.dart';

class SigninScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ButtonStyle filledButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return Colors.white; // Change to white when hovered
          }
          return Colors.red[800]; // Default filled color
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
      appBar: AppBar(title: const Text('Sign In')),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), margin: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40), // Space for logo (if you insert one)
                // You can insert an Image or Widget for your logo here
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username',
                  ),
                ),
                const SizedBox(height: 20), // Spacing between fields
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                  obscureText: true, // Add this for password field
                ),
                Container(margin: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0), child: ElevatedButton(
            style: filledButtonStyle,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen())
              );
            },
            child: const Text('Sign In', style: TextStyle(fontSize: 20)),
          )),
                const SizedBox(height: 40), // Spacing before the button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  child: const Text('Go Back'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

