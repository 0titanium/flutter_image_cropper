import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/presentation/album/album_view_model.dart';
import 'package:provider/provider.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AlbumViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Album'),
      ),
      body: viewModel.image == null
          ? const Center(
              child: Text('선택된 이미지가 없습니다'),
            )
          : Column(
              children: [
                viewModel.croppedFile == null
                    ? Image.file(viewModel.image!)
                    : Image.file(File(viewModel.croppedFile!.path)),
                TextButton(
                    onPressed: () {
                      viewModel.cropImage(context);
                    },
                    child: const Text('편집'))
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.pickImage,
        tooltip: '이미지 선택',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
