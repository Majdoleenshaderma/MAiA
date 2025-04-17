import 'package:flutter/material.dart';
class userModel{
  final int id;
  final String name;
  final String phon;

  userModel({
    required this.id,
    required this.phon,
    required this.name,

});
}

class User extends StatelessWidget {
  List<userModel> users=[
    userModel(id: 1,name: "Majdoleen M M Shaderma",phon: "+798211956"),
    userModel(id: 2, phon:"+796452644", name:"Ahmad M M Shaderma"),
    userModel(id: 3, phon: "+792468534", name: "Nour M M Shaderma"),
    userModel(id: 4, phon: "+796539215", name: "Batoul M M Shaderma"),
    userModel(id: 1,name: "Majdoleen M M Shaderma",phon: "+798211956"),
    userModel(id: 2, phon:"+796452644", name:"Ahmad M M Shaderma"),
    userModel(id: 3, phon: "+792468534", name: "Nour M M Shaderma"),
    userModel(id: 4, phon: "+796539215", name: "Batoul M M Shaderma"),
    userModel(id: 1,name: "Majdoleen M M Shaderma",phon: "+798211956"),
    userModel(id: 2, phon:"+796452644", name:"Ahmad M M Shaderma"),
    userModel(id: 3, phon: "+792468534", name: "Nour M M Shaderma"),
    userModel(id: 4, phon: "+796539215", name: "Batoul M M Shaderma"),
    userModel(id: 1,name: "Majdoleen M M Shaderma",phon: "+798211956"),
    userModel(id: 2, phon:"+796452644", name:"Ahmad M M Shaderma"),
    userModel(id: 3, phon: "+792468534", name: "Nour M M Shaderma"),
    userModel(id: 4, phon: "+796539215", name: "Batoul M M Shaderma")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Users"),
      ),
      body:ListView.separated(
          itemBuilder: (context,index)=>buildUserItem(users[index]),
          separatorBuilder:(context,index)=>Padding(
            padding: const EdgeInsetsDirectional.only(start: 20),
            child: Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length)


    );
  }
}
Widget buildUserItem(userModel user)=> Padding(
  padding: const EdgeInsets.all(15.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    // mainAxisAlignment: MainAxisAlignment.start,
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black,
        child: Text('${user.id}',
          style:TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(width: 20,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${user.name}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 8,),
          Text('${user.phon}',
            style: TextStyle(
              color: Colors.grey,

            ),
          ),
        ],

      ),
    ],

  ),
);