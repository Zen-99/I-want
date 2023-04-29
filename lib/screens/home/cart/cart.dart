import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:i_want/screens/home/categories/selectedItem.dart';
class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}
class Item{
  String? name;
  int? id;
  String? priceToPay;
  String? imageUrl;
  String?owner;
  
  Item(this.id,this.name,this.owner,this.imageUrl,this.priceToPay);
}
class _CartState extends State<Cart> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  var itemArr=[];

    @override
    void initState(){
       List<Item> itemArr=[];
       getItems();
       super.initState();
    }
    getItems() async {
      if(itemArr.isNotEmpty){
        itemArr=[];
      }
      final User? user = auth.currentUser;
      final uEmail = user?.email;
      await FirebaseFirestore.instance.collection('Items').where('current_buyer',isEqualTo:uEmail).get().then((QuerySnapshot querySnapshot) => {
        querySnapshot.docs.forEach((doc) {
            setState(() {
              itemArr.add(Item(doc.get('item_id'),doc.get("name"), doc.get("owner"), doc.get("image1"), doc.get("price_to_pay")));
            });
        })
      });
    }
      Widget cartItem(itemId,name,owner,img,price)=>GestureDetector(
      onTap: () =>{
        itemId=itemId.toString(),
        Navigator.push(context,MaterialPageRoute(builder: (context) => SelectedItem(id:itemId,)))

      },
      child:Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
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
              width: 40,
              height: 40,
              child: Image.network(img),
              ),
            ),
            SizedBox(width: 4),
            Container(
              width:(MediaQuery.of(context).size.width)/2,
              height:(MediaQuery.of(context).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 6, 20, 4),
                    child:Text(name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 4),
                    child:Text('by ${owner}',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey)),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 4),
                    child:Text('Rs.${price}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  ),
              ],
              ),
            ),
          ]  
        ),
      ),
      width:(MediaQuery.of(context).size.width),
      height:160,
      ),
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
      body: Container(
        height: double.infinity,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder:(context, index){
              return cartItem(itemArr[index].id,itemArr[index].name,itemArr[index].owner,itemArr[index].imageUrl,itemArr[index].priceToPay);
            },
            itemCount: itemArr.length,
          ),
      ),
    );
  }
}