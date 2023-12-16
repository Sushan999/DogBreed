import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'home_ui.dart';

class Breeds extends StatefulWidget {
  @override
  _BreedsState createState() => _BreedsState();
}

class _BreedsState extends State<Breeds> {
  int _selectedIndex = 1; // Set the index to 1 for the "Breeds" tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90.0,
        title: Column(
          children: [
            SizedBox(height: 15.0),
            Text(
              'Breeds',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            iconSize: 40,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
            Container(
              width: 350,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.green.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' Type the breed you want to search',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.search,
                    size: 28,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          SizedBox(height: 12), // Add space here
          Expanded(
            child: ListView.builder(

              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  height: 70,
                  width: 2022,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent.withOpacity(0.3),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.red, // Set the selected icon color to red
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  textStyle: TextStyle(color: _selectedIndex == 0 ? Colors.red : Colors.black),
                  onPressed: () {
                    // Navigate to Home screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.paw,
                  text: 'Breeds',
                  textStyle: TextStyle(color: _selectedIndex == 1 ? Colors.red : Colors.black),
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Saved',
                  textStyle: TextStyle(color: _selectedIndex == 2 ? Colors.red : Colors.black),
                ),
                GButton(
                  icon: LineIcons.medkit,
                  text: 'Care',
                  textStyle: TextStyle(color: _selectedIndex == 3 ? Colors.red : Colors.black),
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
    );
  }
}