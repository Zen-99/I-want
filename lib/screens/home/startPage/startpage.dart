import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:i_want/screens/home/categories/selectedItem.dart';
class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}
class Item{
  String? name;
  int? id;
  String? imageUrl;
  String? currPrice;

  Item(this.name,this.id,this.imageUrl,this.currPrice);
}
 var dataArr=[];
class _StartpageState extends State<Startpage> {
  final _textController=TextEditingController();
    @override
    void initState(){
       List<Item> dataArr=[];
       getData();
       super.initState();
    }
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    getData() async {
      if(dataArr.isNotEmpty){
        dataArr=[];
      }
      await FirebaseFirestore.instance.collection('Items').where('clicked_count',isGreaterThan: 0).orderBy('clicked_count',descending: true).get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
            setState(() {
              dataArr.add(Item(doc.get("name"), doc.get("item_id"), doc.get("image1"),doc.get("current_price")));
            });
        })
      });    
    }
  @override
  Widget build(BuildContext context) {
    Widget categories()=>Container(
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
          Text('Moblie Phones',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
        ]  
        ),
      ),
      width:150,
      height:100,
    );
    Widget buildCard(name,imgUrl,id,currPrice)=>GestureDetector(
        onTap: () =>{
          id=id.toString(),
          Navigator.push(context,MaterialPageRoute(builder: (context) => SelectedItem(id:id,)))

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
                width: 250,
                height: 200,
                child:Image.network(imgUrl),
              ),
              const SizedBox(height: 6),
              Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
              const SizedBox(height: 4),
              Text('Rs.${currPrice}0',style: TextStyle(fontSize: 18))
            ]  
            ),
          ),
          width:250,
          height:350,
      )
    );


    return Scaffold(
            body:Container(
            child:Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                  height: 120,
                  padding: EdgeInsets.fromLTRB(25,40,25,15), 
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
                  height: MediaQuery.of(context).size.height-180,
                  child:ListView(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Container(
                        child:Image.network('https://www.androidguys.com/wp-content/uploads/2015/12/wave-wallpaper-background-511-1024x640.jpg'),
                        width:(MediaQuery.of(context).size.width),
                      ),
                      Container(
                        margin:EdgeInsets.fromLTRB(15,25,5,25),  
                        width: (MediaQuery.of(context).size.width),
                        child:new Text('Trending Items', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15,0,15,0),
                        height:280,
                        child:ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context, index){
                            return buildCard(dataArr[index].name,dataArr[index].imageUrl,dataArr[index].id,dataArr[index].currPrice);
                          },
                          itemCount: dataArr.length>6?6:dataArr.length,
                        ),
                      ),
                      // Container(
                      //   margin:EdgeInsets.fromLTRB(15,25,5,25),  
                      //   width: (MediaQuery.of(context).size.width),
                      //   child:new Text('Closing Today', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
                      // ),
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(15,0,15,0),
                      //   height:210,
                      //   child:ListView(
                      //     scrollDirection: Axis.horizontal,
                      //     children: [
                      //       categories(),
                      //       SizedBox(width: 12),
                      //       categories(),
                      //       SizedBox(width: 12),
                      //       categories(),
                      //       SizedBox(width: 12),
                      //       categories()
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]
            ),
          ),
    );
  }
}