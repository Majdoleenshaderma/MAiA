import 'package:flutter/material.dart';
import 'package:learn/auth/login.dart';

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: Duration(seconds: 3),
          curve: Curves.linearToEaseOut,
          tween: Tween<double>(begin: 2000.0, end: 70.0),
          builder: (context, value, child) {
            return FittedBox(
              child: Text(
                'MAiA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: value,
                  color: Color(0xff780000),
                ),
              ),
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
