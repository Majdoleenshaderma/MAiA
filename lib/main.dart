import 'package:flutter/material.dart';
import 'package:learn/auth/logo.dart';

import 'auth/login.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(


      debugShowCheckedModeBanner:false,
      home:NotFound(),
    );
}}
