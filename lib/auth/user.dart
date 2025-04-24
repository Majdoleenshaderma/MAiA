import 'package:flutter/material.dart';

class userModel {
  final int id;
  final String name;
  final String phon;

  userModel({
    required this.id,
    required this.phon,
    required this.name,
  });
}

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  int _currentIndex = 1;

  List<userModel> users = [
    userModel(id: 1, name: "Majdoleen M M Shaderma", phon: "+798211956"),
    userModel(id: 2, phon: "+796452644", name: "Ahmad M M Shaderma"),
    userModel(id: 3, phon: "+792468534", name: "Nour M M Shaderma"),
    userModel(id: 4, phon: "+796539215", name: "Batoul M M Shaderma"),
    userModel(id: 5, name: "Majdoleen M M Shaderma", phon: "+798211956"),
    userModel(id: 6, phon: "+796452644", name: "Ahmad M M Shaderma"),
    userModel(id: 7, phon: "+792468534", name: "Nour M M Shaderma"),
    userModel(id: 8, phon: "+796539215", name: "Batoul M M Shaderma"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Users"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => buildUserItem(users[index]),
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(start: 20),
          child: Container(
            width: double.infinity,
            height: 2,
            color: Colors.grey[300],
          ),
        ),
        itemCount: users.length,
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
              icon: Icon(Icons.tonality,
                  color: _currentIndex == 2 ? Color(0xff05064e) : Colors.grey),
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

  Widget buildUserItem(userModel user) => Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: Text(
            '${user.id}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${user.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${user.phon}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
