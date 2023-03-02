import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
    int _selectedIndex = 0;
  final _textController=TextEditingController();
  static const List<Widget> _widgetOptions = <Widget>[
    
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
              icon: Icon(Icons.category),
              label: 'My Items',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Item',
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