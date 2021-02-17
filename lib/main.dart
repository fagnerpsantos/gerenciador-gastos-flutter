import 'package:flutter/material.dart';
import 'screens/constants/color_contant.dart';

import 'screens/home/home_screen.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: kBlueColor,
          backgroundColor: kBackgroundColor
      ),
      home: HomeScreen(),
    );
  }
}
