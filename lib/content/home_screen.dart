import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:ocr_app/theme/app_theme.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isProcessing = false;

  // Method to extract text from image using Google ML Kit
  Future<String> extractTextFromImage(String imagePath) async {
    TextRecognizer? textRecognizer;

    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

      final RecognizedText recognizedText = await textRecognizer.processImage(
        inputImage,
      );

      if (recognizedText.text.isEmpty) {
        return 'No text found in the image.\n\nTips:\n• Make sure the image has clear, readable text\n• Try better lighting or higher resolution\n• Ensure text is not too small or blurry';
      }

      return recognizedText.text;
    } catch (e) {
      debugPrint('Error extracting text: $e');

      // Provide helpful error message based on error type
      if (e.toString().contains('MlKitException')) {
        return 'ML Kit Error: Unable to process image.';
      }

      return 'Error: Unable to extract text from image.\n\nDetails: ${e.toString()}\n\nPlease try:\n• Using a different image\n• Running on a real device\n• Checking your internet connection (first-time model download)';
    } finally {
      textRecognizer?.close();
    }
  }

  // Method to show dialog with extracted text
  void showExtractedTextDialog(BuildContext context, String extractedText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
              maxWidth: MediaQuery.of(context).size.width * 0.9,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: MyAppTheme.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: MyAppTheme.lightPurple, width: 2),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.text_fields,
                      color: MyAppTheme.primaryPurple,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Extracted Text',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: MyAppTheme.primaryPurple,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: MyAppTheme.darkPurple),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Divider
                Divider(color: MyAppTheme.lightPurple, thickness: 1.5),
                const SizedBox(height: 16),

                // Extracted text content
                Flexible(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MyAppTheme.lightPurple.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: MyAppTheme.borderColor,
                          width: 1,
                        ),
                      ),
                      child: SelectableText(
                        extractedText.isEmpty
                            ? 'No text found in the image.'
                            : extractedText,
                        style: TextStyle(
                          fontSize: 16,
                          color: MyAppTheme.blackColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Copy button
                ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: extractedText));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: MyAppTheme.whiteColor,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Text copied to clipboard!',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        backgroundColor: MyAppTheme.primaryPurple,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(Icons.copy, size: 20),
                  label: Text(
                    'Copy All Text',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyAppTheme.primaryPurple,
                    foregroundColor: MyAppTheme.whiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                onTap: _isProcessing
                    ? null
                    : () async {
                        try {
                          setState(() {
                            _isProcessing = true;
                          });

                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image != null) {
                            debugPrint("Image selected: ${image.path}");

                            // Show loading indicator
                            if (mounted) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: MyAppTheme.whiteColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CircularProgressIndicator(
                                            color: MyAppTheme.primaryPurple,
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            'Extracting text...',
                                            style: TextStyle(
                                              color: MyAppTheme.primaryPurple,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            // Extract text from image
                            String extractedText = await extractTextFromImage(
                              image.path,
                            );

                            // Close loading dialog
                            if (mounted) {
                              Navigator.of(context).pop();

                              // Show extracted text dialog
                              showExtractedTextDialog(context, extractedText);
                            }
                          } else {
                            debugPrint("No image selected.");
                          }
                        } catch (e) {
                          debugPrint("Error: $e");
                          if (mounted) {
                            // Close loading dialog if open
                            try {
                              Navigator.of(context).pop();
                            } catch (_) {}

                            // Show error dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Colors.red[700],
                                    size: 48,
                                  ),
                                  title: Text(
                                    'Processing Failed',
                                    style: TextStyle(
                                      color: MyAppTheme.primaryPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    'Unable to process the image.',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                          color: MyAppTheme.primaryPurple,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isProcessing = false;
                            });
                          }
                        }
                      },
                child: Opacity(
                  opacity: _isProcessing ? 0.5 : 1.0,
                  child: Column(
                    children: [
                      // Animation for image picker button
                      Lottie.asset(
                        'assets/json/Image.json',
                        width: 200,
                        height: 200,
                      ),
                      const SizedBox(height: 1),
                      Text(
                        _isProcessing ? 'Processing...' : 'Tap to add image',
                        style: TextStyle(color: MyAppTheme.primaryPurple),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
