import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Item{
  String? name;
  int? id;
  String? imageUrl;
  String? category;

  Item(this.name,this.id,this.imageUrl,this.category);
}
class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}
// List<double> dataArr=List.filled(7, 0.0);
class _StatsState extends State<Stats> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState(){
    // List<double> dataArr=List.filled(7, 0.0);
    // getData();
    super.initState();
  }
  
  
  // getData() async {
  //   // if(dataArr.isNotEmpty){
  //   //   dataArr=[];
  //   // }
    // final User? user = auth.currentUser;
    // final uEmail = user?.email;
  //   await FirebaseFirestore.instance.collection('Items').where('owner',isEqualTo:uEmail).get().then((QuerySnapshot querySnapshot) => {
  //     querySnapshot.docs.forEach((doc) {
  //         double price=double.parse(doc.get("price_to_pay"));
  //         int dayOfweek=int.parse(doc.get("day_of_week"));
  //         setState(() {
  //           dataArr[dayOfweek-1]+=price;
  //         });
  //     })
  //   });

      
  // }

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uEmail = user?.email;
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
            StreamBuilder(
            stream: FirebaseFirestore.instance
              .collection("Items")
              .where("owner",isEqualTo: uEmail)
              .snapshots(),
            builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
              if(snapshot.hasData){
                int itemCount=0;
                double totalIncome=0.0;
                double maximumBid=0.0;
                snapshot.data?.docs.forEach((doc) {
                  print(doc['price_to_pay']);
                  if(doc['current_buyer']!="null"){
                    itemCount+=1;
                    totalIncome+=double.parse(doc['price_to_pay']);
                    if(maximumBid<double.parse(doc['price_to_pay'])){
                      maximumBid=double.parse(doc['price_to_pay']);
                    }
                  }
                });
                return CarouselSlider(
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
                  "value":totalIncome,
                },
                {
                  "title":"Items sold",
                  "value":itemCount,
                },
                {
                  "title":"maximum bid",
                  "value":maximumBid,
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
              );
              }else{
                return CarouselSlider(
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
                  "value":0,
                },
                {
                  "title":"Items sold",
                  "value":0,
                },
                {
                  "title":"maximum bid",
                  "value":0,
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
              );
              }
            }),
            
          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
            width: double.infinity,
            child: Text("Income per day",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          ),
          StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection("Items")
            .where("owner",isEqualTo: uEmail)
            .snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.hasData){
                List<double> incomeArr=List.filled(7, 0.0);
                snapshot.data?.docs.forEach((doc) {
                  print(doc['price_to_pay']);
                  if(doc['current_buyer']!="null"){
                    incomeArr[int.parse(doc['day_of_week'])-1]+=double.parse(doc['price_to_pay']);
                  }
              });
              // int.parse(snapshot.data?.docs[0]['price_to_pay']);
              return Card(
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
                    data:  incomeArr
                  )
                ),

              );
            }else{
                return Card(
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
                    data: [0,0,0,0,0,0,0]
                  )
                ),

            );
            }
          }),

          SizedBox(height: 40),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0,vertical: 40.0),
            width: double.infinity,
            child: Text("Items sold per day",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          ),
          StreamBuilder(
          stream: FirebaseFirestore.instance
            .collection("Items")
            .where("owner",isEqualTo: uEmail)
            .snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(snapshot.hasData){
                List<double> itemArr=List.filled(7, 0.0);
                snapshot.data?.docs.forEach((doc) {
                  // print(doc['price_to_pay']);
                  if(doc['current_buyer']!="null"){
                    itemArr[int.parse(doc['day_of_week'])-1]+=1;
                  }
              });
              // int.parse(snapshot.data?.docs[0]['price_to_pay']);
              return Card(
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
                    data:  itemArr
                  )
                ),

              );
            }else{
                return Card(
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
                    data: [0,0,0,0,0,0,0]
                  )
                ),

            );
            }
          }),
        ]),
      )
    );
  }
}