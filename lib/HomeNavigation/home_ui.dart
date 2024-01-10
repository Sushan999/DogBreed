import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pupscan/models.dart';
import '../Camera/camera_page.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});
  final int id = 1;

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DogDetail? listBreed;
  List<String> imageList = [
    'https://thumbs.dreamstime.com/b/golden-retriever-dog-21668976.jpg',
    'https://www.thesprucepets.com/thmb/3ABKoAPm0Hu4PcWsDH1giawq7ck=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/chinese-dog-breeds-4797219-hero-2a1e9c5ed2c54d00aef75b05c5db399c.jpg',

    // Add more image paths as needed
  ];

  List<String> upperimageList = [
    'https://hips.hearstapps.com/hmg-prod/images/wolf-dog-breeds-siberian-husky-1570411330.jpg',
    'https://monsterbullies.com/wp-content/uploads/2020/08/LILLY1-sml.jpg',
    'https://www.akc.org/wp-content/uploads/2016/11/AdobeStock_94435211-800x600.jpeg',
  ];
  List<String> upperName = ['Husky', 'Terrier', 'Boston', 'German'];
  List<String> lowerName = ['Golden Retriever', 'Pug'];

  int _selectedIndex = 0;
  List<CameraDescription>? cameras;

  Future<void> _loadDetails() async {
    final response = await http.post(
        Uri.parse('http://192.168.254.198:8000/breed/breed_detail/'),
        body: {'index': widget.id.toString()});
    listBreed =
        DogDetail.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    setState(() {
      upperimageList = [listBreed!.img, listBreed!.img0, listBreed!.img1];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // Set the system overlay style to match the app's UI color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.black,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading:
            false, // Set the desired height of the AppBar
        title: const Column(
          children: [
            // Use SizedBox to add space above the title
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
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      cameras = await availableCameras();
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CameraPage(cameras: cameras!)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: 350,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.green.withOpacity(
                              0.2), // Set the background color to transparent green
                        ),
                        child: const Row(
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
                            SizedBox(
                                width:
                                    10), // Add some spacing between the text and the icon
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
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Popular Dog Breeds",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: upperimageList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.withOpacity(0.3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              child: Image.network(
                                upperimageList[index %
                                    upperimageList
                                        .length], // Use modulus to loop through images
                                fit: BoxFit.cover, width: 600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Text(
                                    upperName[
                                        index], // Replace with actual title
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Recommended for you",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "View All",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
              ),

              // Add the vertical ListView.builder here
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.withOpacity(0.3),
                          ),
                          child: Row(
                            children: [
                              // Left side - Image
                              Container(
                                width: 100,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  child: Image.network(
                                    imageList[index %
                                        imageList
                                            .length], // Use modulus to loop through images
                                    fit: BoxFit.cover, width: 600,
                                  ),
                                ),
                              ),
                              // Middle - Text
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Center(
                                    child: ListTile(
                                      title: Text(
                                        lowerName[index],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "Toy Group",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Right side - Arrow Icon
                              Container(
                                width: 50,
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 24,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
