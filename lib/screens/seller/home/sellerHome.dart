import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:i_want/screens/seller/home/items/myItems.dart';
import 'package:i_want/screens/seller/home/profile/sellerProfile.dart';
import 'package:i_want/screens/seller/home/stats/stats.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  int _selectedIndex = 0;
  final _textController=TextEditingController();
  static const List<Widget> _widgetOptions = <Widget>[
    Stats(),
    MyItems(),
    SellerProfile(),
    //
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body:_widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: true,
          items: 
          const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_graph),
              label: 'Stats',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              label: 'My Items',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.man),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
  }
}