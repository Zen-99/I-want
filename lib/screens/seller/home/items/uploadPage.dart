import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';


class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  
  final ImagePicker _imagePicker=ImagePicker();


  void selectMultipleImages() async{
    final XFile? selected = await _imagePicker.pickImage(source:ImageSource.gallery);
    

  }

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
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Product Name",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              SizedBox(height: 10),
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Product name Here',
              ),
            ),
            ],)
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Product Category",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
                SizedBox(height: 10),
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
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Price",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              SizedBox(height: 10),
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Price here',
              ),
            ),

            ],)
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Add images",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  alignment:  Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(0, 5, 10, 4),
                  child:ElevatedButton(
                  
                    onPressed: () {
                      //selectMultipleImages();
                    },
                    child: const Text('Upload'),
                  ),
                ),
              // GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),itemCount: 5, itemBuilder: (BuildContext context,int index){
              //     return Container(
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             color: Colors.amber,
              //             borderRadius: BorderRadius.circular(15)),
              //         child: Container(child: Text("hello"),
              //         ),
              //     );
              //   })
            ],)
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Column(children: [
              Container(
                width: double.maxFinite,
                height: 25,
                // color: Colors.red,
                child: Text("Description",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              SizedBox(height: 10),
              TextField(
              maxLines: 8,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Description here...',
              ),
            ),
            ],)
          ),
          Container(
            // width: double.infinity,
            padding: EdgeInsets.fromLTRB(35,40,35,15), 
            child: Row(children: [
              Container(
                alignment:  Alignment.bottomLeft,
                margin: EdgeInsets.fromLTRB(0, 5, 10, 4),
                child:ElevatedButton(
                  onPressed: () {
                    
                  },
                  child: const Text('Save'),
                ),
              ),
              Container(
                alignment:  Alignment.bottomRight,
                margin: EdgeInsets.fromLTRB(0, 5, 10, 4),
                child:ElevatedButton(
                  
                  onPressed: () {
                    
                  },
                  child: const Text('Cancel'),
                ),
              ),
            ],),
          ),
        ],)
      ),
    );
  }
}