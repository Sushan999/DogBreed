import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auto-Sliding Image Slideshow'),
        ),
        body: ImageSlideshow(),
      ),
    );
  }
}

class ImageSlideshow extends StatefulWidget {
  @override
  _ImageSlideshowState createState() => _ImageSlideshowState();
}

class _ImageSlideshowState extends State<ImageSlideshow> {
  final List<String> imageUrls = [
    "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-running-outdoors.jpg",
    "https://www.akc.org/wp-content/uploads/2017/11/Affenpinschers-together-in-the-grass.jpg",
    "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-at-the-2016-ANC.jpg",
  ];

  int currentPage = 0;
  late PageController pageController = PageController(initialPage: currentPage);
  late Timer timer;

  @override
  void initState() {
    super.initState();

    // Set up a timer for auto-sliding every 5 seconds
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
      if (currentPage < imageUrls.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: imageUrls.length,
      onPageChanged: (index) {
        setState(() {
          currentPage = index;
        });
      },
      itemBuilder: (context, index) {
        return Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
        );
      },
    );
  }
}
