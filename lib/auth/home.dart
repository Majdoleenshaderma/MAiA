// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// //
// // class Home extends StatelessWidget{
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           leading: IconButton(onPressed: () {
// //             print('menu');
// //           }, icon: Icon(Icons.menu)),
// //           title: Text(
// //               'first app'),
// //           actions: [
// //             IconButton(onPressed: () {
// //               print('onNotinotification');
// //             }, icon: Icon(Icons.notification_important)),
// //             //Icon(Icons.notification_important),
// //             IconButton(onPressed: () {
// //               print('search');
// //             }, icon: Icon(Icons.search)),
// //             //Icon(Icons.search),
// //
// //           ],
// //           centerTitle: true,
// //           backgroundColor: Colors.pinkAccent,
// //           //elevation: 10,
// // ),
// // body:SafeArea(child:Text('hello'), )
// //     body:Container(
// //       color: Colors.grey,
// //       width:double.infinity,
// //       child: Column(
// //         mainAxisSize: MainAxisSize.max,
// //         mainAxisAlignment:MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //
// //         children: [
// //           Container(
// //             child: Text('first',
// //             style: TextStyle(color:
// //             Colors.blue,
// //               fontSize: 30,
// //               backgroundColor: Colors.black,
// //
// //
// //
// //
// //                       )),
// //
// //           ),
// //           // Container(
// //           //   child: Text('second',
// //           //       style: TextStyle(color:
// //           //       Colors.white,
// //           //         fontSize: 30,
// //           //         backgroundColor: Colors.lightGreen,
// //           //
// //           //
// //           //
// //           //       )),
// //           //
// //           // ),
// //
// //         ],
// //
// //       ),
// //     ),
// //     body: Container(
// //       color: Colors.grey,
// //       height: double.infinity,
// //       child: Row(
// //          mainAxisSize: MainAxisSize.max,
// //         mainAxisAlignment: MainAxisAlignment.end,
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children:[
// //           Expanded(
// //             child: Container(
// //               child: Text('First',
// //               style:TextStyle(
// //                 backgroundColor: Colors.blue,
// //
// //               )
// //
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: Container(
// //               child: Text('second',
// //                   style:TextStyle(
// //                     backgroundColor:Colors.amberAccent,
// //
// //                   )
// //
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: Container(
// //               child: Text('third',
// //                   style:TextStyle(
// //       backgroundColor: Colors.lightGreen,
// //                   )
// //
// //               ),
// //             ),
// //           ),
// //           Expanded(
// //             child: Container(
// //               child: Text('fourth',
// //                   style:TextStyle(
// //                     backgroundColor: Colors.deepOrange
// //
// //                   )
// //
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //     body: SingleChildScrollView(
// //
// //       //crossAxisAlignment: CrossAxisAlignment.start,//عشان تصير كل الكلمات تبلش اول سطر
// //       // scrollDirection: Axis.horizontal,
// // child: Column(
// //
// //       children: [
// //         Text(
// //           'Majdoleen',
// //           style: TextStyle(
// //             fontSize: 40,
// //           ),
// //         ),
// //         Text(
// //           'batool',
// //           style: TextStyle(
// //             fontSize: 40,
// //           ),
// //         ),
// //         Text(
// //           'ahmad',
// //           style: TextStyle(
// //             fontSize: 40,
// //           ),
// //         ),
// //         Text(
// //           'noor',
// //           style: TextStyle(
// //             fontSize: 40,
// //           ),
// //         ),
// //       ],
// //
// // )),
// //     );}
// // );}}
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
//
// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         titleSpacing: 20.0,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20.0,
//               backgroundImage: NetworkImage(
//                   'https://avatars.hsoubcdn.com/bc503acfe263d585118cbf24cc9531ed?s=256'), // الصورة الجديدة
//             ),
//             SizedBox(
//               width: 15.0,
//             ),
//             Text(
//               'Chats',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: CircleAvatar(
//               radius: 15.0,
//               backgroundColor: Colors.grey,
//               child: Icon(
//                 Icons.camera_alt,
//                 size: 16.0,
//                 color:Color(0xff780000),
//               ),
//             ),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: CircleAvatar(
//               radius: 15.0,
//               backgroundColor: Colors.grey,
//               child: Icon(
//                 Icons.edit,
//                 size: 16.0,
//                 color:Color(0xff780000),
//               ),
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 cursorColor:Color(0xff780000),
//                 decoration: InputDecoration(
//                   hintText: 'Search',
//                   hintStyle: TextStyle(
//                     color: Color(0XFF780000),
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   prefixIcon: Icon(Icons.search,color:Color(0xff780000),),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//                   contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                   focusedBorder:OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20)
//                     ),
//                     borderSide: BorderSide(
//
//                       color: Color(0xff780000),
//
//                     ),
//                   ),
//
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 height: 100.0,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) => buildStoryItem(),
//                   separatorBuilder: (context, index) => SizedBox(
//                     width: 20.0,
//                   ),
//                   itemCount: 5,
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               ListView.separated(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) => buildChatItem(),
//                 separatorBuilder: (context, index) => SizedBox(
//                   height: 20.0,
//                 ),
//                 itemCount: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 1. build item
//   // 2. build list
//   // 3. add item to list
//
//   // arrow function
//   Widget buildChatItem() => Row(
//     children: [
//       Stack(
//         alignment: AlignmentDirectional.bottomEnd,
//         children: [
//           CircleAvatar(
//             radius: 30.0,
//             backgroundImage: NetworkImage(
//                 'https://avatars.hsoubcdn.com/bc503acfe263d585118cbf24cc9531ed?s=256'),
//           ),
//           Padding(
//             padding: const EdgeInsetsDirectional.only(
//               bottom: 3.0,
//               end: 3.0,
//             ),
//             child: CircleAvatar(
//               radius: 7.0,
//               backgroundColor: Color(0xff780000),
//             ),
//           ),
//         ],
//       ),
//       SizedBox(
//         width: 20.0,
//       ),
//       Expanded(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed Abdullah Ahmed',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             SizedBox(
//               height: 5.0,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'hello my name is abdullah ahmed hello my name is abdullah ahmed',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10.0,
//                   ),
//                   child: Container(
//                     width: 7.0,
//                     height: 7.0,
//                     decoration: BoxDecoration(
//                       color: Color(0xff05064e),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '02:00 pm',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
//
//   Widget buildStoryItem() => Container(
//     width: 60.0,
//     child: Column(
//       children: [
//         Stack(
//           alignment: AlignmentDirectional.bottomEnd,
//           children: [
//             CircleAvatar(
//               radius: 30.0,
//               backgroundImage: NetworkImage(
//                   'https://avatars.hsoubcdn.com/bc503acfe263d585118cbf24cc9531ed?s=256'),
//             ),
//             Padding(
//               padding: const EdgeInsetsDirectional.only(
//                 bottom: 3.0,
//                 end: 3.0,
//               ),
//               child: CircleAvatar(
//                 radius: 7.0,
//                 backgroundColor: Color(0xff780000),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 6.0,
//         ),
//         Text(
//           'Abdullah Mansour Ali Mansour',
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     ),
//   );
// }
