import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ads extends StatefulWidget {
  const Ads({super.key});

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  PageController pageController =PageController(viewportFraction: 0.85);
  int myslideIndex=0;
  @override
  Widget build(BuildContext context) {
    return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: 9,
                itemBuilder: (context,index){
                  return Container(
                    width:110,
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    color: Colors.red),
                    
                  );
                }
            ),

    );
  }
}