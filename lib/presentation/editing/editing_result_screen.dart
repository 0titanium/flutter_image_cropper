import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class EditingResultScreen extends StatefulWidget {
  const EditingResultScreen({
    super.key,
    required this.image,
  });

  final CroppedFile image;

  @override
  State<EditingResultScreen> createState() => _EditingResultScreenState();
}

class _EditingResultScreenState extends State<EditingResultScreen> {
  late final CroppedFile? croppedFile;

  @override
  void initState() {
    super.initState();
    // initState에서 GoRouter의 extra로 전달된 croppedFile을 가져옴
    croppedFile = widget.image;
  }

  Future saveImage() async {
    if (croppedFile == null) return;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName.jpg');

    try {
      await storageReference.putFile(File(croppedFile!.path));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing'),
      ),
      body: Center(
        child: Image.file(File(croppedFile!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: saveImage,
        tooltip: '저장',
        child: const Icon(Icons.save),
      ),
    );
  }
}
