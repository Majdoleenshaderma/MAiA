// import 'package:flutter/material.dart';
// import 'package:learn/auth/login.dart';
//
// class NotFound extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: TweenAnimationBuilder<double>(
//           duration: Duration(seconds: 3),
//           curve: Curves.linearToEaseOut,
//           tween: Tween<double>(begin: 2000.0, end: 70.0),
//           builder: (context, value, child) {
//             return FittedBox(
//               child: Text(
//                 'mAIa',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//
//                   fontSize: value,
//                   color: Color(0xff780000),
//                 ),
//               ),
//             );
//           },
//           onEnd: () {
//             Future.delayed(Duration(seconds: 2), () {
//               Navigator.pushReplacement(
//                 context,
//                 PageRouteBuilder(
//                   pageBuilder: (context, animation, secondaryAnimation) => Login(),
//                   transitionsBuilder: (context, animation, secondaryAnimation, child) {
//                     final fade = Tween(begin: 0.0, end: 1.0).animate(
//                       CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//                     );
//                     return FadeTransition(opacity: fade, child: child);
//                   },
//                   transitionDuration: Duration(milliseconds: 800),
//                 ),
//               );
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:learn/auth/login.dart';


class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff510202),
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: Duration(seconds: 3),
          curve: Curves.linearToEaseOut,
          tween: Tween<double>(begin: 3000.0, end: 200.0),
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: value,
                  height: value,
                  child: Image.asset('assets/images/logo.png'),
                ),
                SizedBox(height: 20),
                Text(
                  'My AI Assistant',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
          onEnd: () {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => Login(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    final fade = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                    );
                    return FadeTransition(opacity: fade, child: child);
                  },
                  transitionDuration: Duration(milliseconds: 800),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}

