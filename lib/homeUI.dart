import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

import 'Project/camera_page.dart';
import 'preview_page.dart'; // Import your PreviewPage

class HomeUI extends StatefulWidget {
  @override
  HomeUIState createState() => HomeUIState();
}

class HomeUIState extends State<HomeUI> {
  static int selectedIndex = 0;
  onTappedBar(int value) {
    setState(() {
      selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }

  final PageController _pageController = PageController();

  int currentIndex = 0;
  List<CameraDescription>? cameras;
  List<io.File>? _imageList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                cameras = await availableCameras();
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CameraPage(cameras: cameras!)),
                );
                // Add  logic for taking a picture here
              },
              child: const Text("Take a Picture"),
            ),
            SizedBox(height: 16), // Add some spacing between the buttons
            /*ElevatedButton(
              onPressed: () async {
                await _pickImages();
              },
              child: Text('Pick Images'),
            ),*/
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          iconSize: 22,
          selectedFontSize: 15,
          selectedIconTheme: IconThemeData(size: 26.0),
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Breeds',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.deepOrange,
            ),
          ]),
    );
  }

  Future<void> _pickImages() async {
    // Add your logic for picking images here using image_picker package
    try {
      List<XFile> pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages != null) {
        List<io.File> imageFiles =
            pickedImages.map((XFile file) => io.File(file.path)).toList();
        setState(() {
          _imageList = imageFiles;
        });

        // Navigate to PreviewPage with the selected image
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => PreviewPage(picture: pickedImages[0])),
        );
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }
}
