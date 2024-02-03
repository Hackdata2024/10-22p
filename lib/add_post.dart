import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class AddPostService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> addPost() async {
    // Get current user
    User? user = _auth.currentUser;
    if (user == null) {
      print('User not logged in.');
      return;
    }

    // Ask user for post description
    print('Enter the description for the post:');
    String description = stdin.readLineSync() ?? '';

    // Pick image from gallery
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      print('No image selected.');
      return;
    }

    // Upload image to Firebase Storage
    Reference storageReference = _storage.ref().child('posts/${user.uid}/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = storageReference.putFile(File(image.path));
    TaskSnapshot storageSnapshot = await uploadTask.whenComplete(() => null);
    String postUrl = await storageSnapshot.ref.getDownloadURL();

    // Create a new document in the 'posts' collection
    String postId = _firestore.collection('posts').doc().id;
    await _firestore.collection('posts').doc(postId).set({
      'postId': postId,
      'postUrl': postUrl,
      'uid': user.uid,
      'username': user.displayName ?? 'Anonymous',
      'description': description,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print('Post added successfully.');
  }
}

void main() {
  AddPostService addPostService = AddPostService();
  addPostService.addPost();
}
