import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(25), 
            child:new TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: (){
                  _textController.toString();
                },
                icon: const Icon(Icons.search),
              )
            ),
          ),
          ),
          Container(
            
          )
        ]
      ),
    );
  }
}