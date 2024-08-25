import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album'),
      ),
      body: _image == null
          ? const Center(
              child: Text('선택된 이미지가 없습니다'),
            )
          : Column(
              children: [
                Image.file(_image!),
                TextButton(
                    onPressed: () {
                      context.go('/editing');
                    },
                    child: const Text('편집'))
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        tooltip: '이미지 선택',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
