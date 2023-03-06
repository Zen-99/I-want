import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  List boxVals=[10000,23,25000];
  
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
            SizedBox(height: 40,),
            CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayCurve: Curves.decelerate,
               enlargeCenterPage: true,
               enlargeFactor: 0.3,
            ),
            items: [
            {
              "title":"Total income",
              "value":this.boxVals[0],
            },
            {
              "title":"Items sold",
              "value":this.boxVals[1],
            },
            {
              "title":"maximum bid",
              "value":this.boxVals[2],
            }].map((i) {
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
                      alignment: Alignment.center,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
                      child: Column(children: [
                        Text(i["title"].toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(i["value"].toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold))
                      ]),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
            width: double.infinity,
            child: Text("Income per day",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 97, 99, 98),
              ),
              borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
            ),
            child:Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
                child:SfSparkLineChart( //Enable the trackball
                trackball: SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap), //Enable marker
                marker: SparkChartMarker(
                displayMode: SparkChartMarkerDisplayMode.all),//Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                data: <double>[1500, 500, 600, 0, 100, 200, 700, 700, 400, 1000, 1300, 600, 700, 500, 1100, 500, 300],
              )
            ),

        ),
                  SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
            width: double.infinity,
            child: Text("Items sold per day",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 97, 99, 98),
              ),
              borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
            ),
            child:Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
                child:SfSparkLineChart( //Enable the trackball
                trackball: SparkChartTrackball(
                activationMode: SparkChartActivationMode.tap), //Enable marker
                marker: SparkChartMarker(
                displayMode: SparkChartMarkerDisplayMode.all),//Enable data label
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                data: <double>[1500, 500, 600, 0, 100, 200, 700, 700, 400, 1000, 1300, 600, 700, 500, 1100, 500, 300],
              )
            ),

        ),
        ]),
      )
    );
  }
}