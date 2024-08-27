import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/presentation/camera/camera_view_model.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CameraViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: viewModel.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return viewModel.controller != null
                ? Stack(
                    children: [
                      CameraPreview(viewModel.controller!),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FloatingActionButton(
                            onPressed: viewModel.switchCamera,
                            child: const Icon(Icons.switch_camera),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: Text('Camera not available'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.takePicture(context);
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
