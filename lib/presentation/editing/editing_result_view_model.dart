import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class EditingResultViewModel extends ChangeNotifier {
  CroppedFile? croppedFile;

  EditingResultViewModel({required this.croppedFile});

  Future<void> saveImage() async {
    if (croppedFile == null) return;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName.jpg');

    try {
      await storageReference.putFile(File(croppedFile!.path));
      notifyListeners();
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
