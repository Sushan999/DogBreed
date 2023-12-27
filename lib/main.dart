import 'dart:io';

import 'package:dogbreed/Project/camera_page.dart';
import 'package:dogbreed/Project/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dogbreed/Navigation/main_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const Home(),
//     );
//   }
// }

// Testing by Tek
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PupScan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _HomeState();
}

class _HomeState extends State<MyHome> {
  List<Map<String, Widget>>? _pages;
  int _selectedPageIndex = 0;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    _pages = [
      {
        'page': const Home(),
      },
      {
        'page': const HomePage(),
      },
      {
        'page': const Breed(),
      }
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  final setColor = const Color.fromARGB(255, 31, 192, 36).withOpacity(1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: _pages?[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
          height: 69,
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
              height: kBottomNavigationBarHeight * 0.98,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                          minWidth: 80.0,
                          onPressed: () {
                            setState(() {
                              _selectedPageIndex = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home_outlined,
                                color: _selectedPageIndex == 0
                                    ? setColor
                                    : Colors.grey,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: _selectedPageIndex == 0
                                        ? setColor
                                        : Colors.grey),
                              )
                            ],
                          )),
                      MaterialButton(
                          minWidth: 70.0,
                          onPressed: () {
                            setState(() {
                              _selectedPageIndex = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                weight: 10,
                                LineIcons.dog,
                                color: _selectedPageIndex == 1
                                    ? setColor
                                    : Colors.grey,
                              ),
                              Text(
                                "Breed",
                                style: TextStyle(
                                    color: _selectedPageIndex == 1
                                        ? setColor
                                        : Colors.grey),
                              )
                            ],
                          ))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MaterialButton(
                          minWidth: 70.0,
                          onPressed: () {
                            setState(() {
                              _selectedPageIndex = 2;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_border_rounded,
                                color: _selectedPageIndex == 2
                                    ? setColor
                                    : Colors.grey,
                              ),
                              Text(
                                "Saved",
                                style: TextStyle(
                                    color: _selectedPageIndex == 2
                                        ? setColor
                                        : Colors.grey),
                              )
                            ],
                          )),
                      MaterialButton(
                          minWidth: 80.0,
                          onPressed: () {
                            setState(() {
                              _selectedPageIndex = 3;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.heart,
                                color: _selectedPageIndex == 3
                                    ? setColor
                                    : Colors.grey,
                              ),
                              Text(
                                "Care",
                                style: TextStyle(
                                    color: _selectedPageIndex == 3
                                        ? setColor
                                        : Colors.grey),
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ))),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        hoverElevation: 10,
        splashColor: null,
        tooltip: 'Scan',
        focusColor: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 31, 192, 36).withOpacity(1),
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.center_focus_strong_rounded,
          color: Colors.white,
        ),
        onPressed: () async {
          cameras = await availableCameras();
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CameraPage(cameras: cameras!)),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("HOme")),
    );
  }
}

class Breed extends StatelessWidget {
  const Breed({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("PET")),
    );
  }
}
