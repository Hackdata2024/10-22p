import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyUploadScreen extends StatefulWidget {
  const MyUploadScreen({super.key});

  @override
  _MyUploadScreenState createState() => _MyUploadScreenState();
}

class _MyUploadScreenState extends State<MyUploadScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedImagePath = '';
  String _location = '';

  // Method to select image from gallery
  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImagePath = pickedImage.path;
      });
    }
  }

  // Method to get user's current location
  Future<void> _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _location = '${position.latitude}, ${position.longitude}';
    });
  }

  // Method to submit data to Firestore
  Future<void> _submitPost() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if(user!=null)
      {
        print('User UID: ${user.uid}');
        print('User Display Name: ${user.displayName}');
        print('User Photo URL: ${user.photoURL}');
      }
    String uid = user!.uid;
    String username = user.displayName ?? 'Unknown';
    String photoUrl = user.photoURL ?? '';


    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('posts').add({
      'uid': uid,
      'username': username,
      'photoUrl': photoUrl,
      'description': _descriptionController.text,
      'location': _location,
    });

    // Clear the text field and selected image path after submitting
    _descriptionController.clear();
    setState(() {
      _selectedImagePath = '';
      _location = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.arrow_back_outlined),
          title: Text("Initiate A Report"),
          actions: [
            OutlinedButton(onPressed: () {}, child: const Text("Post")),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          )),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: TextField(
                maxLines: 6,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Click here for adding the description',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(Icons.image, size: 48, color: Colors.lightGreen),
                      SizedBox(height: 10),
                      const Text(
                        'Upload an Image',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 5),
                      const Text('Select any PNG or JPG files'),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _selectImage,
                        child: const Text('Upload Image'),
                      ),
                      SizedBox(height: 16.0),
                      _selectedImagePath.isNotEmpty && !kIsWeb
                          ? Image.file(
                        File(_selectedImagePath),
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : _selectedImagePath.isNotEmpty && kIsWeb
                          ? Image.network(
                        _selectedImagePath,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : const SizedBox.shrink(),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () async {
                          await _getUserLocation();
                          await _submitPost();
                          _showSuccessDialog(context);
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success'),
        content: Text('Image and description successfully uploaded'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}