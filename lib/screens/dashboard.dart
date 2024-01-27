import 'package:flutter/material.dart';
import 'package:fnf_fitness/screens/categories.dart';
import 'package:fnf_fitness/screens/homepage.dart';

import 'package:fnf_fitness/screens/profile.dart';

class Dashboard extends StatefulWidget {
  static const routeName = '/dashboard';
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _pages = [];

  @override
  void initState() {
    _pages = [
      {
        'page': HomePageScreen(),
      },
      {
        'page': Categories(),
      },
      {
        'page': Profile(),
      },
    ];
    super.initState();
  }

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Color(0xffEAFAF5),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff108319),
          unselectedItemColor: const Color(0xff000000),
          onTap: onTapped,
          elevation: 0,
        ));
  }
}



//Color(0xffE8FCF6)