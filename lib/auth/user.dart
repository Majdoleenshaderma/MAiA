import 'package:flutter/material.dart';
import 'login.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  int _currentIndex = 1;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,

        elevation: 0,
        title: Row(

          children: [
            Spacer(),
            IconButton(
              icon: Icon(Icons.book, color: Color(0xff05064e)),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, top: 40, bottom: 8),
              alignment: Alignment.centerLeft,
              child: Text(
                'History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Divider(color: Colors.grey[300]),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Recent Activity'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Spacer(),
            ListTile(
              leading: Icon(Icons.logout, color: Color(0xff780000)),
              title: Text(
                'Log out',
                style: TextStyle(color: Color(0xff780000)),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person,
                  color: _currentIndex == 0 ? Color(0xff05064e) : Colors.grey),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.home,
                  color: _currentIndex == 1 ? Color(0xff05064e) : Colors.grey),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/mirror.png',
                width: 26,
                height: 26,
                color: _currentIndex == 2 ? Color(0xff05064e) : Colors.grey,
                colorBlendMode: BlendMode.modulate,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
