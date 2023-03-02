import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({super.key});

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
      Widget info()=>Container(
    child:Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromARGB(255, 97, 99, 98),
          ),
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
      child:Column(
        children:[

      ]  
      ),
    ),
    margin: EdgeInsets.fromLTRB(10,0,10,0),
    width:(MediaQuery.of(context).size.width),
    height:80,
  );
  @override
  Widget build(BuildContext context) {
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
            Container(
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
                      name: 'Roshan Senevirathne',
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
                    child:Text("Roshan Senevirathne",style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 25))
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                ],
              )
            ),
            info(),
            info(),
            info()
          ],
        ),

      )
    );
  }
}