import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
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
          SizedBox(height: 30),
          Text("Time Remaining",style: TextStyle(fontSize: 25)),
          SizedBox(height: 20),
          TimerCountdown(
            format: CountDownTimerFormat.daysHoursMinutesSeconds,
            endTime: DateTime.now().add(
              Duration(
                days: 5,
                hours: 14,
                minutes: 27,
                seconds: 34,
              ),
            ),
            onEnd: () {
              print("Timer finished");
            },
          ),
          SizedBox(height: 30),
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
          Container(
            margin: EdgeInsets.all(15),
            height: 25,
            width: MediaQuery.of(context).size.width,
            child:Text("Samsung A52",textAlign: TextAlign.left,style: TextStyle(fontSize: 25)),
          ),
          
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(15),
            height: 20,
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Text("Current Price",style: TextStyle(fontSize: 20)),
              SizedBox(width: 20),
              Text("Rs.4900.00",style: TextStyle(fontSize: 20)),
            ]),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: Column(children: [
              Text("Comments",style: TextStyle(fontSize: 15)),
              
            ]),
          )
        ]
      ),
    );
  }
}