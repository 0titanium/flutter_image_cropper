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
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameraService = CameraService();
      cameras = await cameraService.getCameras();

      if (cameras.isNotEmpty) {
        selectedCameraIndex = 0;
        await _initCameraController(cameras[selectedCameraIndex]);
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _initCameraController(
      CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    try {
      _initializeControllerFuture = controller!.initialize();
      await _initializeControllerFuture;
    } catch (e) {
      print('Error initializing camera controller: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _switchCamera() async {
    if (cameras.length > 1) {
      setState(() {
        _initializeControllerFuture =
            null; // 임시로 null로 설정하여 dispose된 컨트롤러를 사용하지 않도록 함
      });

      selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
      await _initCameraController(cameras[selectedCameraIndex]);

      if (mounted) {
        setState(() {
          // 새 카메라 컨트롤러가 초기화된 후 UI를 다시 빌드
          _initializeControllerFuture = controller!.initialize();
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('보조 카메라가 없습니다')),
      );
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
                ? Stack(
                    children: [
                      CameraPreview(controller!),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: FloatingActionButton(
                            onPressed: _switchCamera,
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
        onPressed: _takePicture,
        child: const Icon(Icons.camera),
      ),
    );
  }
}
