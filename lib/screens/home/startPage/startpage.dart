import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  final _textController=TextEditingController();
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
    Widget buildCard()=>Container(
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
            Text('Samsung A52',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
            const SizedBox(height: 4),
            Text("120.00",style: TextStyle(fontSize: 18))
          ]  
          ),
        ),
        width:150,
        height:150,
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
                        height:210,
                        child:ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            buildCard(),
                            SizedBox(width: 12),
                            buildCard(),
                            SizedBox(width: 12),
                            buildCard(),
                            SizedBox(width: 12),
                            buildCard()
                          ],
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.fromLTRB(15,25,5,25),  
                        width: (MediaQuery.of(context).size.width),
                        child:new Text('Trending Categories', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15,0,15,0),
                        height:210,
                        child:ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            categories(),
                            SizedBox(width: 12),
                            categories(),
                            SizedBox(width: 12),
                            categories(),
                            SizedBox(width: 12),
                            categories()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          ),
    );
  }
}