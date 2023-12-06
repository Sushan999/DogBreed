import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../camera_page.dart';
import 'documents.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<CameraDescription>? cameras;

  @override
  Widget build(BuildContext context) {
    // Set the system overlay style to match the app's UI color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.black,
    ));

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90.0,  // Set the desired height of the AppBar
        title: Column(
          children: [
            SizedBox(height: 15.0),  // Use SizedBox to add space above the title
            Text(
              'Home',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  cameras = await availableCameras();
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: cameras!)),
                  );

                },
                child: Container(
                  width: 350,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green.withOpacity(0.2), // Set the background color to transparent green
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '  Scan and identify the doggo ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 10), // Add some spacing between the text and the icon
                      Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 24,
                        color: Colors.green,
                      ),
                      // Add other widgets here if needed
                    ],
                  ),
                ),
              ),


            ],

          ),

          Padding(
            padding: const EdgeInsets.only(left: 20,top: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text("Popular Dog Breeds",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text("View All",style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                color: Colors.green
              ),),
            ),
          ),
          Ads()
        ],
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
          top: 1.0,
        ),
        child: MaterialButton(
          onPressed: () async {
            cameras = await availableCameras();
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CameraPage(cameras: cameras!)),
            );
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