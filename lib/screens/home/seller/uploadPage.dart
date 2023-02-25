import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar:AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shadowColor: Theme.of(context).colorScheme.shadow,
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(
        //       Icons.shopping_cart,
        //       color: Colors.blue,
        //     ),
        //     onPressed: () {
        //       // do something
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(
        //       Icons.category,
        //       color: Colors.blue,
        //     ),
        //     onPressed: () {
        //       // do something
        //     },
        //   )
        // ],
      ),
      body:SingleChildScrollView(
        child:Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Product Name",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Product name Here',
              ),
            ),
            ],)
          ),
          Container(
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Product Category",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
                Container(
                  width: double.maxFinite,
                  // color: Colors.red,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      hint: Text(
                        'Select Item',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme
                                  .of(context)
                                  .hintColor,
                        ),
                      ),
                      items: items
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                              .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 140,
                      itemHeight: 40,
                    ),
                  ),
                ),
            ],)
          ),
          Container(
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Price",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Price here',
              ),
            ),
            ],)
          ),
        ],)
      ),
    );
  }
}