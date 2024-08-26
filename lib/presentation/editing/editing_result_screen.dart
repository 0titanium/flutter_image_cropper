import 'dart:io';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing'),
      ),
      body: Center(
        child: Image.file(File(croppedFile!.path)),
      ),
    );
  }
}
