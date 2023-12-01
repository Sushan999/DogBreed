import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

  List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Breeds',
      style: optionStyle,
    ),
    Text(
      'Saved',
      style: optionStyle,
    ),
    Text(
      'Caree',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  textStyle: TextStyle(color: Colors.black),
                ),
                GButton(
                  icon: LineIcons.paw,
                  text: 'Breeds',
                  textStyle: TextStyle(color: Colors.black),
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Saved',
                  textStyle: TextStyle(color: Colors.black),
                ),
                GButton(
                  icon: LineIcons.medkit,
                  text: 'Care',
                  textStyle: TextStyle(color: Colors.black),
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 50.0,
          top: 1.0, // Adjusted top padding
        ),
        child: MaterialButton(
          onPressed: () {
            // Add your camera icon functionality here
          },
          color: Colors.grey[100]!,
          shape: CircleBorder(),
          child: Icon(
            LineIcons.camera,
            color: Colors.black,
            size: 30.0,
          ),
          padding: EdgeInsets.all(15.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}