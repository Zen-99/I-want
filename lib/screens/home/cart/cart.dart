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
              width:(MediaQuery.of(context).size.width)/3,
              height:(MediaQuery.of(context).size.height),
              margin: EdgeInsets.all(10),
              child:Container(
              child: Image.network('https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW9iaWxlJTIwcGhvbmV8ZW58MHx8MHx8&w=1000&q=80'),
              ),
            ),
            SizedBox(width: 4),
            Container(
              width:(MediaQuery.of(context).size.width)/1.8,
              height:(MediaQuery.of(context).size.height),
              // color:Colors.blue,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 6, 10, 4),
                    child:Text('Samsung A52',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 4),
                    child:Text('by Roshan',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 4),
                    child:Text('120\$',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  ),
                  
                  Container(
                    width: double.infinity,
                    alignment:  Alignment.topRight,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 4),
                    child:ElevatedButton(
                    
                    onPressed: () {},
                    child: const Text('remove'),
                  ),
                  ),
              ],
              ),
            ),
          ]  
        ),
      ),
      width:(MediaQuery.of(context).size.width),
      height:160,
      
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
          cartItem(),
          cartItem(),
          cartItem(),
          cartItem(),
          cartItem(),
          cartItem(),
        ])
      ),
    );
  }
}