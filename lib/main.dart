import 'package:flutter/material.dart';
import 'screens/constants/color_contant.dart';

import 'screens/home/home_screen.dart';
import 'package:asuka/asuka.dart' as asuka;


void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: asuka.builder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: kBlueColor,
          backgroundColor: kBackgroundColor
      ),
      home: HomeScreen(),
    );
  }
}
