# Simple OCR App

A minimal Flutter app that extracts text from images using Google ML Kit.

## Features

- Pick images from gallery
- Extract text using OCR
- View extracted text in a popup dialog
- Copy text to clipboard

## Requirements

- Flutter SDK
- Android device or emulator
- Google ML Kit Text Recognition

## Demo Video
[Watch the demo video here](https://github.com/user-attachments/assets/119623e2-3e7a-4e67-a6f5-6830a7061a03)

## Setup

1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## Usage

1. Tap on the image picker button
2. Select an image from your gallery
3. Wait for text extraction
4. View the extracted text in the dialog
5. Copy text using the copy button

## Dependencies

- `google_mlkit_text_recognition` - OCR functionality
- `image_picker` - Image selection
- `lottie` - Animations

## Note

For best results, use a real Android device. The ML Kit library may not work properly on x86_64 emulators.
