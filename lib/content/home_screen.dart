import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo animation as JSON
              Lottie.asset('assets/json/OCR.json', width: 200, height: 200),
              Text(
                'M I N I M A L - O C R',
                style: TextStyle(fontSize: 24, color: MyAppTheme.primaryPurple),
              ),
              const SizedBox(height: 20),

              // Tap to add image from gallery
              GestureDetector(
                onTap: () async {
                  debugPrint("vai yeta yeta!!");
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    File imgFile = File(image.path);
                    debugPrint("Image selected: ${imgFile.path}");
                  } else {
                    debugPrint("No image selected.");
                  }
                },
                child: Column(
                  children: [
                    // Animation for image picker button
                    Lottie.asset(
                      'assets/json/Image.json',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap to add image',
                      style: TextStyle(color: MyAppTheme.primaryPurple),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
