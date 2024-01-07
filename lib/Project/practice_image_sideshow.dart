// import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Horizontal Image Slideshow'),
// //         ),
// //         body: ImageSlideshow(),
// //       ),
// //     );
// //   }
// // }

// // // class ImageSlideshow extends StatelessWidget {
// // //   final List<String> imageUrls = [
// // //     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-running-outdoors.jpg",
// // //     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinschers-together-in-the-grass.jpg",
// // //     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-at-the-2016-ANC.jpg",
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return PageView.builder(
// // //       itemCount: imageUrls.length,
// // //       itemBuilder: (context, index) {
// // //         return Image.network(
// // //           imageUrls[index],
// // //           fit: BoxFit.cover,
// // //         );
// // //       },
// // //     );
// // //   }
// // // }
// // // import 'package:flutter/material.dart';

// // // void main() {
// // //   runApp(MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       home: Scaffold(
// // //         appBar: AppBar(
// // //           title: Text('Horizontal Image Slideshow'),
// // //         ),
// // //         body: ImageSlideshow(),
// // //       ),
// // //     );
// // //   }
// // // }

// // class ImageSlideshow extends StatefulWidget {
// //   @override
// //   _ImageSlideshowState createState() => _ImageSlideshowState();
// // }

// // class _ImageSlideshowState extends State<ImageSlideshow> {
// //   final List<String> imageUrls = [
// //     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-running-outdoors.jpg",
// //     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinschers-together-in-the-grass.jpg",
// //     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-at-the-2016-ANC.jpg",
// //   ];

// //   int currentPage = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         Expanded(
// //           child: PageView.builder(
// //             itemCount: imageUrls.length,
// //             onPageChanged: (index) {
// //               setState(() {
// //                 currentPage = index;
// //               });
// //             },
// //             itemBuilder: (context, index) {
// //               return Image.network(
// //                 imageUrls[index],
// //                 fit: BoxFit.cover,
// //               );
// //             },
// //           ),
// //         ),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             IconButton(
// //               icon: Icon(Icons.arrow_back),
// //               onPressed: () {
// //                 if (currentPage > 0) {
// //                   setState(() {
// //                     currentPage--;
// //                   });
// //                 }
// //               },
// //             ),
// //             Text(
// //               "${currentPage + 1} / ${imageUrls.length}",
// //               style: TextStyle(fontSize: 18),
// //             ),
// //             IconButton(
// //               icon: Icon(Icons.arrow_forward),
// //               onPressed: () {
// //                 if (currentPage < imageUrls.length - 1) {
// //                   setState(() {
// //                     currentPage++;
// //                   });
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Horizontal Image Slideshow'),
//         ),
//         body: ImageSlideshow(),
//       ),
//     );
//   }
// }

// class ImageSlideshow extends StatefulWidget {
//   @override
//   _ImageSlideshowState createState() => _ImageSlideshowState();
// }

// class _ImageSlideshowState extends State<ImageSlideshow> {
//   final List<String> imageUrls = [
//     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-running-outdoors.jpg",
//     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinschers-together-in-the-grass.jpg",
//     "https://www.akc.org/wp-content/uploads/2017/11/Affenpinscher-at-the-2016-ANC.jpg",
//   ];

//   int currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: AlignmentDirectional.topStart,
//       children: [
//         PageView.builder(
//           itemCount: imageUrls.length,
//           onPageChanged: (index) {
//             setState(() {
//               currentPage = index;
//             });
//           },
//           itemBuilder: (context, index) {
//             return Image.network(
//               imageUrls[index],
//               fit: BoxFit.cover,
//             );
//           },
//         ),
//         Positioned(
//           top: 16.0,
//           left: 16.0,
//           child: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               if (currentPage > 0) {
//                 setState(() {
//                   currentPage--;
//                 });
//               }
//             },
//           ),
//         ),
//         Positioned(
//           top: 16.0,
//           right: 16.0,
//           child: IconButton(
//             icon: Icon(Icons.arrow_forward),
//             onPressed: () {
//               if (currentPage < imageUrls.length - 1) {
//                 setState(() {
//                   currentPage++;
//                 });
//               }
//             },
//           ),
//         ),
//         Positioned(
//           top: 16.0,
//           right: 50.0,
//           child: Text(
//             "${currentPage + 1} / ${imageUrls.length}",
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ],
//     );
//   }
// }

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
  late PageController pageController;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentPage);

    // Set up a timer for auto-sliding every 5 seconds
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (currentPage < imageUrls.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 500),
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
