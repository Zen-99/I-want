import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:flutter/src/widgets/container.dart';
import "package:flutter/material.dart";

class SelectedItem extends StatefulWidget {
  const SelectedItem({super.key});

  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
        title: const Text('Samsung A52'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shadowColor: Theme.of(context).colorScheme.shadow,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.blue,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.category,
              color: Colors.blue,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text("Time Remaining"),
          SizedBox(height: 20),
          DigitalClock(
            hourDigitDecoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 5)),
            minuteDigitDecoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue, width: 5)),
            secondDigitDecoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue,width: 5),
                shape: BoxShape.circle),
            secondDigitTextStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.blue),
          ),
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
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.blue
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),

        ]
      ),
    );
  }
}