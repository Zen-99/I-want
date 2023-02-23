import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import "package:flutter/material.dart";
import 'package:comment_box/comment/comment.dart';


class SelectedItem extends StatefulWidget {
  const SelectedItem({super.key});

  
  @override
  State<SelectedItem> createState() => _SelectedItemState();
}

class _SelectedItemState extends State<SelectedItem> {

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();


  
  List filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'I love to code',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Tunde Martins',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Biggi Man',
      'pic': 'https://www.adeleyeayodeji.com/img/IMG_20200522_121756_834_2.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];
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
                          imageURLorPath: data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(data[i]['date'], style: TextStyle(fontSize: 10)),
            ),
          )
      ],
    );
  }


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
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            height: 20,
            width: MediaQuery.of(context).size.width,
            child: Row(children: [
              Text("Current Owner",style: TextStyle(fontSize: 20)),
              SizedBox(width: 20),
              Text("Roshan Senevirathne",style: TextStyle(fontSize: 20)),
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
              Text("Rs.4900.00",style: TextStyle(fontSize: 20)),
            ]),
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
  }
}