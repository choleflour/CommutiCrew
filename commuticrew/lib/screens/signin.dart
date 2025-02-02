import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
  if (_formKey.currentState!.validate()) {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-in successful!')),
      );

      // Navigate to HomeScreen and remove the Sign-in screen from the stack
      Navigator.pushReplacementNamed(context, '/home');

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Container (
        width: double.infinity, // Full width
        height: double.infinity, // Full height
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 254, 182), // Background color
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Center(
            child: Column (
            children: [ Container(margin: const EdgeInsets.only(top: 60.0), child: const Image(image: AssetImage('assets/images/allyintroduction.png'))), SingleChildScrollView(
              child: Form(
                key: _formKey,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your email',
                            labelStyle: TextStyle(color : Color(0xffd7263d)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => value!.isEmpty ? 'Enter email' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your password',
                            labelStyle: TextStyle(color : Color(0xffd7263d)),
                          ),
                          obscureText: true,
                          validator: (value) =>
                              value!.length < 6 ? 'Password must be 6+ chars' : null,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: _signIn,
                          // style: ButtonStyle(
                          //   backgroundColor: MaterialStateProperty.all<Color>(Color(0xff227619)),
                          // ),
                          child: const Text("Let's Begin !!", style: TextStyle(fontSize: 20, color: Color(0xff227619)),)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ), ),
        ),
      );
  }
}
