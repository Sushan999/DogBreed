import 'package:dogbreed/Project/home_ui.dart';

import '../main.dart';
import 'nav_bar.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 0;
  List<Widget> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      const Home(),
      const HomePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[selectedTab],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 64,
        width: 64,
        child: FloatingActionButton.small(
          backgroundColor: Colors.white,
          elevation: 0,
          onPressed: () => debugPrint("Add Button pressed"),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: Colors.green),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Icon(
            Icons.center_focus_strong_rounded,
            color: Colors.green,
          ),
        ),
      ),
      bottomNavigationBar: NavBar(
        pageIndex: selectedTab,
        onTap: (index) {
          setState(() {
            selectedTab = index;
          });
        },
      ),
    );
  }
}
