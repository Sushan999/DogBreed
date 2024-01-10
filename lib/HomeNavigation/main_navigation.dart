import 'package:camera/camera.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pupscan/BreedListPage/breed_list.dart';
import 'package:pupscan/chatbot/breed_select_chat.dart';
import 'package:pupscan/Camera/camera_page.dart';
import 'package:pupscan/HomeNavigation/home_ui.dart';
import 'package:flutter/material.dart';
import 'package:pupscan/SearchPage/search_ui.dart';

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
        'page': const BreedListPage(),
      },
      {
        'page': const SerachPage(),
      },
      {
        'page': const BreedListPageBot(),
      }
    ];
    super.initState();
  }

  final setColor = const Color.fromARGB(255, 31, 192, 36).withOpacity(1);

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
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
                                  Icons.search_outlined,
                                  color: _selectedPageIndex == 2
                                      ? setColor
                                      : Colors.grey,
                                ),
                                Text(
                                  "Search",
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
                                  "ChatBot",
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
        floatingActionButton: Visibility(
          visible: !showFab,
          child: FloatingActionButton(
            hoverElevation: 10,
            splashColor: null,
            tooltip: 'Scan',
            focusColor: Colors.blue,
            backgroundColor:
                const Color.fromARGB(255, 31, 192, 36).withOpacity(1),
            elevation: 4,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.center_focus_strong_rounded,
              color: Colors.white,
            ),
            onPressed: () async {
              cameras = await availableCameras();
              // ignore: use_build_context_synchronously
              pushToCamera(context, cameras!);
            },
          ),
        ));
  }

  void pushToCamera(BuildContext context, List<CameraDescription> cameras) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CameraPage(cameras: cameras)),
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
