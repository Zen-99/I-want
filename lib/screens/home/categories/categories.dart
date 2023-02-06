import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {

    Widget categories(String categoryType)=>Container(
      child:Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 97, 99, 98),
            ),
            borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
          ),
        child:Column(
          children:[
          Container(
            child:Image.network('https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW9iaWxlJTIwcGhvbmV8ZW58MHx8MHx8&w=1000&q=80'),
          ),
          const SizedBox(height: 6),
          Text(categoryType,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        ]  
        ),
      ),
      width:150,
      height:100,
    );

    return Scaffold(
      appBar:AppBar(
        title: const Text('Categories'),
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
      body: SingleChildScrollView(
      child:Column(children: [
        Container(
          margin:EdgeInsets.fromLTRB(15,25,5,25),  
          width: (MediaQuery.of(context).size.width),
          child:new Text('Electronic Devices', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15,0,15,0),
          height:210,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categories("Electronics"),
              SizedBox(width: 12),
              categories("Electronics"),
              SizedBox(width: 12),
              categories("Electronics"),
              SizedBox(width: 12),
              categories("Electronics")
            ],
          ),
        ),
        Container(
          margin:EdgeInsets.fromLTRB(15,25,5,25),  
          width: (MediaQuery.of(context).size.width),
          child:new Text('Furniture', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15,0,15,0),
          height:210,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categories("Furniture"),
              SizedBox(width: 12),
              categories("Furniture"),
              SizedBox(width: 12),
              categories("Furniture"),
              SizedBox(width: 12),
              categories("Furniture")
            ],
          ),
        ),
        Container(
          margin:EdgeInsets.fromLTRB(15,25,5,25),  
          width: (MediaQuery.of(context).size.width),
          child:new Text('Colths', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15,0,15,0),
          height:210,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categories("Colths"),
              SizedBox(width: 12),
              categories("Colths"),
              SizedBox(width: 12),
              categories("Colths"),
              SizedBox(width: 12),
              categories("Colths")
            ],
          ),
        ),
        Container(
          margin:EdgeInsets.fromLTRB(15,25,5,25),  
          width: (MediaQuery.of(context).size.width),
          child:new Text('Vehicles', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15,0,15,0),
          height:210,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categories("Vehicles"),
              SizedBox(width: 12),
              categories("Vehicles"),
              SizedBox(width: 12),
              categories("Vehicles"),
              SizedBox(width: 12),
              categories("Vehicles")
            ],
          ),
        ),
        Container(
          margin:EdgeInsets.fromLTRB(15,25,5,25),  
          width: (MediaQuery.of(context).size.width),
          child:new Text('Sports Items', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15,0,15,0),
          height:210,
          child:ListView(
            scrollDirection: Axis.horizontal,
            children: [
              categories("Sport Items"),
              SizedBox(width: 12),
              categories("Sport Items"),
              SizedBox(width: 12),
              categories("Sport Items"),
              SizedBox(width: 12),
              categories("Sport Items")
            ],
          ),
        ),
      ]),
      ),
    );
  }
}