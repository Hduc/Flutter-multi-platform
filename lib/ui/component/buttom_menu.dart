import 'package:flutter/material.dart';
import 'package:severingthing/ui/pages/detail_page.dart';
import 'package:severingthing/ui/pages/home_page.dart';

class ButtomMenu extends StatefulWidget {
  @override
  State<ButtomMenu> createState() => _ButtomMenu();
}

/// This is the private State class that goes with MyStatefulWidget.
class _ButtomMenu extends State<ButtomMenu> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DetailPage(),
    DetailPage(),
    DetailPage(),
    DetailPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.toggle_on),
            label: 'Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
