import 'package:ai_image_generator/constant/colors.dart';
import 'package:ai_image_generator/screen/homepage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Image Generator',
      theme: ThemeData(
        fontFamily: 'WorkSans',
        scaffoldBackgroundColor: ConstantColor.bgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0
        )
      ),
      home: const HomePage(),
    );
  }
}

