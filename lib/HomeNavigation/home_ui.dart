import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pupscan/Api/api.dart';
import 'package:pupscan/DetailPage/detail_screen.dart';
import 'package:pupscan/utils/models.dart';
import '../Camera/camera_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  final int id = 1;

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListBreed> recomBreed = [];
  List<ListBreed> topBreed = [];
  bool isLoading = false;

  List<CameraDescription>? cameras;

  Future<void> _loadDetails() async {
    List<ListBreed> topbreeds = await ApiCalls.loadTopHome();
    List<ListBreed> recombreeds = await ApiCalls.loadRecomHome();
    setState(() {
      recomBreed = recombreeds;
      topBreed = topbreeds;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _navigateToBreedDetails(int index) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (c) {
          return ResultScreen(
            id: index,
          );
        },
      ),
    );
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
      body: topBreed.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: SizedBox(
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
                                  builder: (_) =>
                                      CameraPage(cameras: cameras!)),
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                        itemCount: topBreed.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                _navigateToBreedDetails(topBreed[index].id),
                            child: Container(
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
                                        topBreed[index]
                                            .avatar, // Use modulus to loop through images
                                        fit: BoxFit.cover, width: 600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            topBreed[index]
                                                .breed, // Replace with actual title
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                        child: SizedBox(
                          height: 190,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => _navigateToBreedDetails(
                                    recomBreed[index].id),
                                child: Container(
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
                                            recomBreed[index]
                                                .avatar, // Use modulus to loop through images
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
                                                recomBreed[index].breed,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: const Text(
                                                "Toy Group",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
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
