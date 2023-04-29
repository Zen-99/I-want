import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  String? name;
  String? pic;
  String? date;
  String? message;

  Comment(this.name,this.pic,this.date,this.message);
}
class SelectedItem extends StatefulWidget {
  final String id;

  const SelectedItem({super.key, required this.id, });

  
  @override
  State<SelectedItem> createState() => _SelectedItemState();
}
List filedata = [];
class _SelectedItemState extends State<SelectedItem> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> addtoCart({required String docId,required String currBuyer, required String priceToPay,required String currPrice,
    required int count,required String year,required String month,required String date,required String hours,required String mins,required String sec}) async {
      CollectionReference items = FirebaseFirestore.instance.collection('Items');
      items.doc(docId).update({
        'current_buyer':currBuyer,
        'price_to_pay':priceToPay,
        'current_price':currPrice,
        'clicked_count':count,
        'lastSubmit':{
          'year':year,
          'month':month,
          'date':date,
          'hours':hours,
          'mins':mins,
          'sec':sec
        }
      }).then((value) => print("Added to cart"))
        .catchError((error) => print("Failed to add to cart: $error"));;  

    }
  
  @override
  void initState(){
      List<Comment> filedata=[];
      getComments();
      super.initState();
  }
    getComments() async {
      if(filedata.isNotEmpty){
        filedata=[];
      }
      print("getCOmment called");
      await FirebaseFirestore.instance.collection('Comments').where("item_id",isEqualTo: int.parse(widget.id)).get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
            setState(() {
              filedata.add(Comment(doc.get("name"), doc.get("pic"), doc.get("date"),doc.get("message")));
            });
        })
      });

        
    }
  Widget commentChild(data) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: CommentBox.commentImageParser(
                          imageURLorPath: data?[i].pic)),
                ),
              ),
              title: Text(
                data?[i].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data?[i].message),
              trailing: Text(data?[i].date, style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    final User? user = auth.currentUser;
    final uEmail = user?.email;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection("Items")
        .where("item_id",isEqualTo: int.parse(widget.id))
        .snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
        if(snapshot.hasData){
            var timeDiff=DateTime.now().toUtc().difference(DateTime.utc(int.parse(snapshot.data?.docs[0]['lastSubmit']['year']),int.parse(snapshot.data?.docs[0]['lastSubmit']['month']),int.parse(snapshot.data?.docs[0]['lastSubmit']['date']),int.parse(snapshot.data?.docs[0]['lastSubmit']['hours']),int.parse(snapshot.data?.docs[0]['lastSubmit']['mins']),int.parse(snapshot.data?.docs[0]['lastSubmit']['sec'])));
            List<String> words = timeDiff.toString().split(":");
            var dayDiff=int.parse(snapshot.data?.docs[0]['clockData']['days'])-(int.parse(words[0])/24);
            var hourDiff=int.parse(snapshot.data?.docs[0]['clockData']['hours'])-(int.parse(words[0])%24);
            var minsDiff=int.parse(snapshot.data?.docs[0]['clockData']['mins'])-int.parse(words[1]);
            var secDiff=int.parse(snapshot.data?.docs[0]['clockData']['sec']) -int.parse((words[2].split("."))[0]);

            // print(words);
            // print(dayDiff);
            return Scaffold(
            appBar:AppBar(
            title: Text(snapshot.data?.docs[0]['name'],),
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
          body: SingleChildScrollView(
            child:Column(
            children: [
              SizedBox(height: 30),
              Text("Time Remaining",style: TextStyle(fontSize: 25)),
              SizedBox(height: 20),
              TimerCountdown(
                format: CountDownTimerFormat.daysHoursMinutesSeconds,
                endTime: DateTime.now().add(
                  Duration(
                    days: dayDiff.toInt(),
                    hours: hourDiff.toInt(),
                    minutes:minsDiff.toInt(),
                    seconds: secDiff.toInt()
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
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayCurve: Curves.decelerate,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                ),
                items: [snapshot.data?.docs[0]['image1'],snapshot.data?.docs[0]['image2'],snapshot.data?.docs[0]['image3']].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      if(i!=""){
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            // color: Colors.blue
                          ),
                          child:Image.network(i),
                        );
                      }else{
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            
                          ),
                          child:Image.network("https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930"),
                        );
                        
                      }

                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(15),
                height: 25,
                width: MediaQuery.of(context).size.width,
                child:Text(snapshot.data?.docs[0]['name'],textAlign: TextAlign.left,style: TextStyle(fontSize: 25)),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Text("Current Owner",style: TextStyle(fontSize: 20)),
                  SizedBox(width: 20),
                  Text(snapshot.data?.docs[0]['owner'],style: TextStyle(fontSize: 20)),
                ]),
              ),
              //check commit
              // SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Row(children: [
                  Text("Current Price",style: TextStyle(fontSize: 20)),
                  SizedBox(width: 20),
                  Text("Rs.${snapshot.data?.docs[0]['current_price']}.00",style: TextStyle(fontSize: 20)),
                ]),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 25, 15, 5),
                width: double.infinity,
                height: 50,
                child:StreamBuilder(
                  stream: FirebaseFirestore.instance
                  .collection("Items")
                  .where("item_id",isEqualTo: int.parse(widget.id))
                  .snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                      if(snapshot.data?.docs[0]['current_buyer']==uEmail){
                        return Container(
                          width: double.infinity,
                          height: 50,
                          child: const Text('In your hand',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        );
                      }else{
                        return ElevatedButton(
                          onPressed: () async{
                            var docId=snapshot.data?.docs[0].reference.id;

                            var count=snapshot.data?.docs[0]['clicked_count'];
                            count=count+1;
                            var currPrice=double.parse(snapshot.data?.docs[0]['current_price']);
                            var initPrice=double.parse(snapshot.data?.docs[0]['init_price']);
                            var priceToPay=currPrice;
                            var currBuyer=uEmail.toString();

                            currPrice=currPrice+initPrice/10;
                            DateTime today = DateTime.now();
                            var year=today.year;
                            var month=today.month;
                            var date=today.day;
                            var hours=today.hour;
                            var mins=today.minute;
                            var sec=today.second;

                            await addtoCart(docId:docId.toString(),currBuyer: currBuyer,count: count,currPrice: currPrice.toString(),priceToPay: priceToPay.toString(),year: year.toString(),month: month.toString(),date: date.toString(),hours: hours.toString(),mins: mins.toString(),sec: sec.toString());
                          },
                          child: const Text('Buy',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        );
                      }

                  }
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 25, 15, 5),
                child: Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 15,
                    child: Text("Comments",style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width-20,
                    height:500,
                    child: CommentBox(
                      userImage: CommentBox.commentImageParser(
                          imageURLorPath: "https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg"),
                      child: commentChild(filedata),
                      labelText: 'Write a comment...',
                      errorText: 'Comment cannot be blank',
                      withBorder: false,
                      sendButtonMethod: () {
                        if (formKey.currentState!.validate()) {
                          print(commentController.text);
                          setState(() {
                            var value = {
                              'name': 'New User',
                              'pic':
                                  'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
                              'message': commentController.text,
                              'date': '2021-01-01 12:00:00'
                            };
                            filedata.insert(0, value);
                          });
                          commentController.clear();
                          FocusScope.of(context).unfocus();
                        } else {
                          print("Not validated");
                        }
                      },
                      formKey: formKey,
                      commentController: commentController,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
                    ),
                  ),
                ]),
              )
            ]
          ),
          ),
          
        );
        }else{
          return Container(

          );
        }
      },
    );

  }
}