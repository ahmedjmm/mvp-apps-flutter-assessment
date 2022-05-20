import 'package:flutter/material.dart';
import 'package:mvp_flutter/ui/dish_details.dart';
import 'package:mvp_flutter/ui/google_sign_in.dart';
import 'package:mvp_flutter/ui/main_dishs.dart';
import 'package:mvp_flutter/ui/nav3.dart';
import 'package:mvp_flutter/ui/nav4.dart';
import 'package:mvp_flutter/ui/main_dish.dart';

class Dishes extends StatefulWidget {
  const Dishes({Key? key}) : super(key: key);

  @override
  State<Dishes> createState() => _Dishes();
}

class _Dishes extends State<Dishes> {
  int _selectedBottomNavigationIndex = 0;
  static const List<Widget> bottomNavigationWidgets =[
    MainDishs(), MyGoogleSignIn(), Nav3(), Nav4()
  ];

  void _onBottomNavigationItemTapped(int index) {
    setState(() {
      _selectedBottomNavigationIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: bottomNavigationWidgets[_selectedBottomNavigationIndex]
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dishes'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.delete),
                label: 'recycles'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Bookmarks'
            )
          ],
          currentIndex: _selectedBottomNavigationIndex,
          selectedItemColor: Colors.redAccent,
          unselectedItemColor: Colors.black26,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onBottomNavigationItemTapped,
        )
    );
  }
}
