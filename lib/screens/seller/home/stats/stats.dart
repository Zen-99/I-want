import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/framework.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Statistics'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shadowColor: Theme.of(context).colorScheme.shadow,
        actions: <Widget>[

        ],
      ),
      body:SingleChildScrollView(
        child:Column(children: [
            SizedBox(height: 20,),
            CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              autoPlay: false,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayCurve: Curves.decelerate,
               enlargeCenterPage: true,
               enlargeFactor: 0.3,
            ),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color.fromARGB(255, 97, 99, 98),
                      ),
                      borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
                    ),
                    child: Container(

                    ),
                  );
                },
              );
            }).toList(),
          ),
        ]),
      )
    );
  }
}