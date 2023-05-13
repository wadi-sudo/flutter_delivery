import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:auth_fire/screens/signin_screen.dart';

import 'package:auth_fire/screens/user_info.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class curvedBarScreen extends StatefulWidget {
  @override
  _curvedBarScreenState createState() => _curvedBarScreenState();
}

class _curvedBarScreenState extends State<curvedBarScreen> {
  //State class

  late List<Map<String, Widget>> _pages;
  int _selectedPageIndex = 0;
  GlobalKey<_curvedBarScreenState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('ISKEA'),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                size: 30,
              ),
              tooltip: 'Logout',
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInScreen()));
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('you have been logged out'),
                  backgroundColor: Color.fromARGB(255, 0, 115, 150),
                  padding: EdgeInsets.all(20),
                  behavior: SnackBarBehavior.floating,
                  width: 300,
                  elevation: 30,
                  duration: Duration(milliseconds: 3000),
                ));
              },
            )
          ]),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_bag, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
      ),
      body: Center(
        child: _pages[_selectedPageIndex]['page'],
      ),
    );
  }

  @override
  void initState() {
    _pages = [
      {
        'page': Home(),
      },
      {
        'page': Cart(),
      },
      {
        'page': profile(),
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
