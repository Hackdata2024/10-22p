import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _addPost(String imageUri) async {
    try {
      await _firestore.collection('posts').add({
        'imageUri': imageUri,
        'description': _descriptionController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      print('Post added successfully!');
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garbage Collector App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Replace 'imageUri' with the actual URL of the garbage image
                _addPost('imageUri');
              },
              child: Text('Add Post'),
            ),
          ],
        ),
      ),
    );
  }
}
