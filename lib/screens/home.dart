import 'package:flutter/material.dart';
import 'package:open_weather_api/screens/share.dart';
import 'package:open_weather_api/screens/today.dart';
import 'package:open_weather_api/screens/weekly.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    Today(),
    Weekly(),
    Share(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarDay),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarWeek),
            label: 'Weekly',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.shareAlt),
            label: 'Share',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

}
