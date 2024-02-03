import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBpeLQXmaGLz7IoFidA9JHqh9W7AU-SjVM",
          appId: "1:3852409740:android:01121316c836cfcf3394a9",
          messagingSenderId: "3852409740",
          projectId: "greenrep-fbb2a",
          storageBucket: 'gs://greenrep-fbb2a.appspot.com'
      ));
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                _buildLoginTab(),
                _buildSignupTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginTab() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
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
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.password_outlined),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Login'),
        ),
      ],
    );
  }

  Widget _buildSignupTab() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _usernameController,
            decoration: InputDecoration(
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
            decoration: InputDecoration(
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
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.password_outlined),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _signUp,
          child: Text('Sign Up'),
        ),
      ],
    );
  }

  Future<void> _signUp() async {
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
        // Save user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'username': username,
          'uid': user.uid,
        });
      }
    } catch (e) {
      print('Failed to sign up: $e');
    }
  }
}
