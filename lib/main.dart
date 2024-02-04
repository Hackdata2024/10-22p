import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
import 'package:untitled/honess.dart';
import 'package:untitled/recycle_material.dart';
import 'package:untitled/splashing.dart';
import 'package:untitled/user_points.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBpeLQXmaGLz7IoFidA9JHqh9W7AU-SjVM",
        appId: "1:3852409740:android:01121316c836cfcf3394a9",
        messagingSenderId: "3852409740",
        projectId: "greenrep-fbb2a",
        storageBucket: 'gs://greenrep-fbb2a.appspot.com'
    ),
  );
  runApp(
    DevicePreview(
      builder: (context) => ChangeNotifierProvider(
        create: (context) => UserPointsProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class Myxpp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Myxpp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 190.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                          left: 77,
                          top: 24,
                          child: Image.asset(
                            'images/image3.png',
                            width: 275,
                            height: 95,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: 'Login'),
                      Tab(text: 'Signup'),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _buildLoginTab(context),
                _buildSignupTab(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.password_outlined),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () =>_login(context),
          child: Text('Login'),
        ),
        const SizedBox(
          height: 114,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bottom_image_lighted.png'),
          ),
        )
      ],
    );
  }
  Future<void> _login(BuildContext context) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationExample()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: Text('Failed to log in: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );

    }
  }


  Widget _buildSignupTab(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.password_outlined),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.password_outlined),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => _signUp(context),
          child: const Text('Sign Up'),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bottom_image_lighted.png'),
          ),
        )
      ],
    );
  }
  Future<void> _signUp(BuildContext context) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();
      final String username = _usernameController.text.trim();

      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Set the display name for the user
        await user.updateProfile(displayName: username);

        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'username': username,
          'uid': user.uid,
        });

        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationExample()),
        );
      }
    } catch (e) {
      print('Failed to sign up: $e');
    }
  }

}
