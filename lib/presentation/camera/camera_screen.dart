import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/core/camera/camera_service.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameraService = CameraService();
    final cameras = await cameraService.getCameras();

    if (cameras.isNotEmpty) {
      controller = CameraController(cameras[0], ResolutionPreset.high);

      _initializeControllerFuture = controller?.initialize();

      try {
        await _initializeControllerFuture;
        setState(() {});
      } catch (e) {
        print('Camera initialization failed: $e');
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _takePicture() async {
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }

    try {
      XFile picture = await controller!.takePicture();
      print('Picture taken: ${picture.path}');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return controller != null
                ? CameraPreview(controller!)
                : Center(child: Text('Camera not available'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        child: Icon(Icons.camera),
      ),
    );
  }
}