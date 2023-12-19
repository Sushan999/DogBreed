import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'home_ui.dart';

class Breeds extends StatefulWidget {
  @override
  _BreedsState createState() => _BreedsState();
}

class _BreedsState extends State<Breeds> {
  List<String> imageList = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
    'assets/images/6.jpg',
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/8.jpg',
    'assets/images/8.jpg',
    // Add more image paths as needed
  ];

  List<String> nameList = ["Golden Retriever", "German Shephard", "Pug", "Husky", "Chihuahua", "Shiba Inu", "Boxer", "Boston Terrier", "S", "T"];


  List<String> detailsList = [

    "Golden Retrievers are friendly, intelligent, and devoted. They make excellent family pets. Their gentle temperament and patience also make them superb therapy dogs, bringing joy and comfort to people in hospitals and nursing homes. Their beautiful golden coats and eagerness to please contribute to their popularity as both companions and working dogs.",
    "German Shepherds are known for their loyalty and versatility. They are often used as police and service dogs. With their keen intelligence and trainability, German Shepherds excel in various roles, including search and rescue, detection work, and as guide dogs for individuals with visual impairments. Their strong protective instincts make them not only reliable working partners but also loving and vigilant family members.",
    "Pugs are charming, mischievous, and loving. They have a distinctive wrinkled face and curled tail. Despite their small size, Pugs are known for their big personalities and make delightful additions to any household. Their affectionate nature and adaptability also make them well-suited for apartment living, where their playful antics bring joy and laughter to their owners.",
    "Huskies are known for their striking appearance and friendly demeanor. They are good with families. In addition to their beautiful coat and striking blue eyes, Huskies are renowned for their endurance and strength. Their friendly nature extends to children, making them wonderful family companions who thrive in active environments and enjoy outdoor adventures.",
    "Chihuahuas are small in size but big in personality. They can be bold and confident. Despite their diminutive stature, Chihuahuas often exhibit a fearless attitude and strong-willed nature. Their loyalty to their owners is remarkable, and their portable size makes them perfect for those looking for a compact and spirited canine companion.",
    "Shiba Inus are independent and spirited. They are a Japanese breed known for their fox-like appearance. Shiba Inus, with their distinct curled tails and fox-like faces, have a spirited independence that sets them apart. While they may be reserved around strangers, their loyalty and affectionate nature shine through in the bonds they form with their families.",
    "Boxers are playful, energetic, and loyal. They are great with children and make excellent companions. Boxers' boundless energy and enthusiasm make them ideal playmates for children, and their protective instincts ensure a watchful eye over their loved ones. Their affectionate nature and love for fun and games make them wonderful additions to active households.",
    "Boston Terriers are friendly, intelligent, and affectionate. They have a tuxedo-like coat pattern. Boston Terriers' distinctive black and white coat patterns, coupled with their friendly demeanor, make them both charming and elegant companions. Their intelligence and adaptability contribute to their success as family pets, and their affectionate nature ensures a devoted bond with their owners.",
    "Details for Dog 1", // Replace with actual details
    "Details for Dog 2", // Replace with actual details
  ];

  List<bool> _isExpandedList = List.generate(10, (index) => false);

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
              itemCount: nameList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpandedList[index] = !_isExpandedList[index];
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: _isExpandedList[index] ? 200 : 70,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                imageList[index],
                                width: _isExpandedList[index] ? 120 : 60,
                                height: _isExpandedList[index] ? 120 : 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                        _isExpandedList[index]
                            ? Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nameList[index],
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      detailsList[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            : Text(
                          nameList[index],
                          style: GoogleFonts.lato(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
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