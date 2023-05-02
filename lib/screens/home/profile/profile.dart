import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_want/screens/authentication/authenticatr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    Widget info(String title)=>GestureDetector(
        onTap: () =>{
          if(title=="Log Out"){
             _auth.signOut(),
              Navigator.push(context,MaterialPageRoute(builder: (context) => Authenticate()))
          }

        },
        child:Container(
        child:Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Color.fromARGB(255, 97, 99, 98),
              ),
              borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
            ),
          child:Row(
            children:[
              Container(
                margin: EdgeInsets.fromLTRB(20,0,10,0),
                width:(MediaQuery.of(context).size.width*2/3),
                child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              ),
              Container(
                width:(MediaQuery.of(context).size.width/8),
                child:IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // do something
                  },
                ) ,
              )
          ]  
          ),
        ),
        margin: EdgeInsets.fromLTRB(10,0,10,0),
        width:(MediaQuery.of(context).size.width),
        height:80,
      )
    );

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uEmail = user?.email;
    return Scaffold(
      appBar:AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shadowColor: Theme.of(context).colorScheme.shadow,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.blue,
            ),
            onPressed: () {
              // do something
            },
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.blue,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body:Container(
        child:Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
              .collection("Users")
              .where("email",isEqualTo: uEmail.toString())
              .snapshots(),
              builder:(context,AsyncSnapshot<QuerySnapshot>snapshot){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),
                //color: Colors.amber,
                height:180,
                width: (MediaQuery.of(context).size.width),
                child:Row(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.all(20),
                      child:ProfilePicture(
                        img: snapshot.data?.docs[0]['pro_pic'],
                        name: snapshot.data?.docs[0]['name'],
                        radius: 31,
                        fontsize: 21,
                        // img: 'https://avatars.githubusercontent.com/u/37553901?v=4',
                      )
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width)/2 ,
                      height: 100,
                      alignment: Alignment.center,
                      //color: Colors.amber,
                      child:Text(snapshot.data?.docs[0]['name'],style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25))
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        
                      },
                    ),
                  ],
                )
              );
              }
              ),

            SizedBox(height: 50,),
            info("My Account"),
            info("Notification"),
            info("Help Center"),
            info("Log Out"),
          ],
        ),

      )
    );
  }
}