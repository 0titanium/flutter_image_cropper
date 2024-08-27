import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/presentation/editing/editing_result_view_model.dart';
import 'package:provider/provider.dart';

class EditingResultScreen extends StatefulWidget {
  const EditingResultScreen({
    super.key,
  });

  @override
  State<EditingResultScreen> createState() => _EditingResultScreenState();
}

class _EditingResultScreenState extends State<EditingResultScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditingResultViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editing'),
      ),
      body: Center(
        child: Image.file(File(viewModel.croppedFile!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.saveImage(context);
        },
        tooltip: '저장',
        child: const Icon(Icons.save),
      ),
    );
  }
}
