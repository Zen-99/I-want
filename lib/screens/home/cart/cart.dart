import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
      Widget cartItem()=>Container(
      child:Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 97, 99, 98),
            ),
            borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
          ),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Container(
              width:(MediaQuery.of(context).size.width)/2.5,
              height:(MediaQuery.of(context).size.height),
              
              color:Colors.amber
            ),
            SizedBox(width: 4),
            Container(
              width:(MediaQuery.of(context).size.width)/2,
              height:(MediaQuery.of(context).size.height),
              color:Colors.blue
            ),
          ]  
        ),
      ),
      width:(MediaQuery.of(context).size.width),
      height:150,
      
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('Cart Items'),
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
          SizedBox(height:10),
          cartItem()
        ])
      ),
    );
  }
}