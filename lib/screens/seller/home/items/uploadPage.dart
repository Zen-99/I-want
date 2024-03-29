import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart'; 
import 'package:rflutter_alert/rflutter_alert.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _productController = TextEditingController();
  TextEditingController _subCatController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _desctiptionController = TextEditingController();

  String selectedFileName1 = '';
   String selectedFileName2 = '';
    String selectedFileName3 = '';
  XFile? file1,file2,file3;
  Uint8List? selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  final List<String> items = [
  'Cloths',
  'Furniture',
  'Vehicles',
  'Electronics',
  'Sport Items',
  'Others',
];
String? selectedValue;
    Future<void> uploadItem({required String productName,required String category,required String subCategory, required String price, required String image1,required String image2,required String image3}) async {
    DateTime today = DateTime.now();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uEmail = user?.email;
    var year=today.year;
    var month=today.month;
    var date=today.day;
    var hours=today.hour;
    var mins=today.minute;
    var sec=today.second;
    print("Function called");
    CollectionReference items = FirebaseFirestore.instance.collection('Items');
    final querySnapshot = await items.get();
    return items
        .add({
          'category':category,
          'clicked_count':0,
          'clockData':{
            'days':"5",
            'hours':"20",
            'mins':"20",
            'sec':"59"
          },
          'current_buyer':"null",
          'current_price':price,
          'day_of_week':"0",
          'image1':image1,
          'image2':image2,
          'image3':image3,
          'init_price':price,
          'item_id':(querySnapshot.size+1),
          'lastSubmit':{
            'year':year,
            'month':month,
            'date':date,
            'hours':hours,
            'mins':mins,
            'sec':sec
          },
          'name':productName,
          'owner':uEmail,
          'price_to_pay':price,
          'sub_category':subCategory
        })
        .then((value) => print("item Added"))
        .catchError((error) => print("Failed to add item: $error"));
  }
    void _showPicker(BuildContext context,fileNo) {
    showModalBottomSheet(
      //backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                    ),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      _selectFile(true,fileNo);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(),
                  ),
                  onTap: () {
                    _selectFile(false,fileNo);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 _selectFile(bool imageFrom,fileNo) async {
   if(fileNo==1){
      file1 = await ImagePicker().pickImage(
      source: imageFrom ? ImageSource.gallery : ImageSource.camera,
      );
      if (file1 != null) {
        setState(() {
          selectedFileName1 = file1!.name;
        });
      }
      print(file1?.name);
   }
   else if(fileNo==2){
      file2 = await ImagePicker().pickImage(
      source: imageFrom ? ImageSource.gallery : ImageSource.camera,
      );
      if (file2 != null) {
        setState(() {
          selectedFileName2 = file2!.name;
        });
      }
      print(file2?.name);
   }else{
      file3 = await ImagePicker().pickImage(
      source: imageFrom ? ImageSource.gallery : ImageSource.camera,
      );
      if (file3 != null) {
        setState(() {
          selectedFileName3 = file3!.name;
        });
      }
      print(file3?.name);
   }

  }
  _uploadFile(file) async {
    String imageUrl="";
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('product')
          .child('/' + file.name);

      uploadTask = ref.putFile(File(file.path));

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
      print('Uploaded Image URL ' + imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return imageUrl;
    }
    
  }
  bool isDouble(String value) {
  try {
    double.parse(value);
    return true;
  } catch (e) {
    return false;
  }
}
  Widget categories(fileNo,selectedFileName,file) => GestureDetector(
      onTap: () => {
        _showPicker(context,fileNo)
      },
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 97, 99, 98),
            ),
            borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
          ),
          child: Column(children: [
            Container(
              width: 100,
              height: 100,
              child: selectedFileName=='' ?Image.network('https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930'):Image.file(
                        File(file!.path),
                        fit: BoxFit.fitWidth,
                      ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: EdgeInsets.fromLTRB(2,2,2,2),
              child: Text('Upload Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            )
          ]),
        ),
        width: 110,
        height: 150,
  ));
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: const Text('Add Product'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        shadowColor: Theme.of(context).colorScheme.shadow,
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
              controller: _productController,
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
                child: Text("Sub Category",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              SizedBox(height: 10),
              TextField(
              controller: _subCatController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Sub Category here',
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
              controller: _priceController,
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
                height: 50,
                // color: Colors.red,
                child: Text("Add images",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
              ),
              SizedBox(height: 20),
              Row(children: [
                categories(1,selectedFileName1,file1),
                categories(2,selectedFileName2,file2),
                categories(3,selectedFileName3,file3)
              ],),
              TextButton(
              child: Text(
                "Remove selected",
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                setState(() {
                  file1=null;
                  file2=null;
                  file3=null;
                  selectedFileName1='';
                  selectedFileName2='';
                  selectedFileName3='';
                });

              },
              )
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
              controller: _desctiptionController,
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
                  onPressed: () async{
                    if(_productController.text==""){
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "ERROR",
                        desc: "Product Name cannot be empty",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Got it",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                      print("Product Name cannot be empty");
                    }else if(_subCatController.text==""){
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "ERROR",
                        desc: "Sub category cannot be empty",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Got it",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                      print("Sub category cannot be empty");
                    }else if(_priceController.text==""){
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "ERROR",
                        desc: "Price cannot be empty",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Got it",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                      print("Price cannot be empty");
                    }else if(!isDouble(_priceController.text)){
                      Alert(
                        context: context,
                        type: AlertType.error,
                        title: "ERROR",
                        desc: "Price format is incorrect",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Got it",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          )
                        ],
                      ).show();
                      print("Price format is incorrect");
                    }else if(selectedValue==null){
                        Alert(
                          context: context,
                          type: AlertType.error,
                          title: "ERROR",
                          desc: "Please select a category",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Got it",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              width: 120,
                            )
                          ],
                        ).show();
                       print("Please select a category");
                    }else{
                      String image1="",image2="",image3="";
                      if(file1!=null){
                        image1=await _uploadFile(file1);
                      }
                      if(file2!=null){
                        image2=await _uploadFile(file2);
                      }
                      if(file3!=null){
                        image3=await _uploadFile(file3);
                      }
                      await uploadItem(productName: _productController.text, category: selectedValue as String,subCategory: _subCatController.text,price: _priceController.text,image1: image1,image2: image2,image3: image3);
                          Alert(
                            context: context,
                            type: AlertType.info,
                            title: "Done",
                            desc: "Item was uploaded successfully",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Color.fromRGBO(0, 179, 134, 1.0),
                                radius: BorderRadius.circular(0.0),
                              ),
                            ],
                          ).show();
                    }

                   
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