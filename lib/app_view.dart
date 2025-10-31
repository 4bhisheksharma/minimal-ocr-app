import 'package:flutter/material.dart';
import 'package:ocr_app/content/home_screen.dart';
import 'package:ocr_app/theme/app_theme.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OCR App",
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: MyAppTheme.blackColor,
        appBarTheme: AppBarTheme(
          backgroundColor: MyAppTheme.blackColor,
          elevation: 0,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
