/*
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
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
  List<io.File>? _imageList;

  Future<void> _pickImages() async {
    try {
      final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
      if (selectedImages != null) {
        List<io.File> files = selectedImages.map((XFile xFile) => io.File(xFile.path)).toList();
        setState(() {
          _imageList = files;
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageList != null)
              Column(
                children: _imageList!.map((io.File image) {
                  return Image.file(image);
                }).toList(),
              ),
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Pick Images'),
            ),
          ],
        ),
      ),
    );
  }
}*/
