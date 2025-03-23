import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<List<File>> pickImages() async {
  final List<File> images = [];
  final imagePicker = ImagePicker();
  final pickedImages = await imagePicker.pickMultiImage();
  if (pickedImages.isNotEmpty) {
    for (final img in pickedImages) {
      images.add(File(img.path));
    }
  } 
  return images;
}
