import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:i_want/screens/home/categories/selectedItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Item{
  String? name;
  int? id;
  String? imageUrl;
  String? category;

  Item(this.name,this.id,this.imageUrl,this.category);
}
class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}
  var dataArr=[];
class _CategoriesState extends State<Categories> {
    @override
    void initState(){
       List<Item> dataArr=[];
       getData();
       super.initState();
    }

    List<String> categoryArr = ["Electronics","Furniture","Cloths","Vehicles","Sport Items","Others"];

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    getData() async {
        if(dataArr.isNotEmpty){
          dataArr=[];
        }
        await FirebaseFirestore.instance.collection('Items').get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) {
             setState(() {
               dataArr.add(Item(doc.get("name"), doc.get("item_id"), doc.get("image1"), doc.get("category")));
             });
          })
        });

          
      }

    Widget categories(data)=>GestureDetector(
      onTap: () =>{
        print(data),
        Navigator.push(context,MaterialPageRoute(builder: (context) => const SelectedItem()))

      },
      child:Container(
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
          Text(data,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        ]  
        ),
      ),
      width:150,
      height:80,
      )
    );

  List<Column> getCategoryList() {
    List<Column> catergoryNameArr=[];
    
    for(int i=0;i<categoryArr.length;i++){

      
      catergoryNameArr.add(
      Column(
      children:[
        Container(
          margin:EdgeInsets.fromLTRB(15,25,5,25),  
          width: (MediaQuery.of(context).size.width),
          child:new Text(categoryArr[i], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15,0,15,0),
          height:210,
          child:ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder:(context, index){
              if(dataArr[index]?.category==categoryArr[i]){
                return categories("${dataArr[index].name}");
              }else{
                return Container(
                  height: 0,
                  width: 0,
                );
              }
            },
            itemCount: dataArr.length,


            // children: [categories(categoryArr[i]),
            // SizedBox(width: 8),]
          ),
        ),
      ]),
      );
    }
    return catergoryNameArr;
  }

  @override
  Widget build(BuildContext context) {
    // for(int i=0;i<categoryArr.length;i++){
    //   setState(() {
    //     getData(categoryArr[i]);
    //   });   
    // }
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
      child: Column(children:getCategoryList()),
      ),
    );
  }
}