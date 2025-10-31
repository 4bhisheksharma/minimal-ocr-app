import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr_app/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [Lottie.asset('assets/json/Image.json')]),
      ),
    );
  }
}
