import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_preview/device_preview.dart';
import 'dart:io';

import 'package:untitled/honess.dart';
class MyUploadScreen extends StatefulWidget {
  const MyUploadScreen({super.key});

  @override
  State<MyUploadScreen> createState() => _MyUploadScreenState();
}

class _MyUploadScreenState extends State<MyUploadScreen> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const Icon(Icons.arrow_back_outlined),
          title: const Text("Initiate A Report"),
          actions: [
            OutlinedButton(onPressed: () {}, child: const Text("Post")),

          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1),
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
              height: 200,
              child: TextField(
                maxLines: 6,
                decoration: InputDecoration(
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
            _image == null
                ? const Text('No image selected.',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w300),)
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Icon(Icons.image, size: 48, color: Colors.lightGreen),
                      const SizedBox(height: 10),
                      const Text(
                        'Upload an Image',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text('Select any PNG or JPG files'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Choose Image'),
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
