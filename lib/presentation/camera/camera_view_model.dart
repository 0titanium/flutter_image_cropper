import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_cropper/core/camera/camera_service.dart';

class CameraViewModel extends ChangeNotifier {
  CameraController? controller;
  Future<void>? initializeControllerFuture;
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;
  CroppedFile? _croppedFile;

  CameraViewModel() {
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
      initializeControllerFuture = controller!.initialize();
      await initializeControllerFuture;
    } catch (e) {
      print('Error initializing camera controller: $e');
    }

    notifyListeners();
  }

  void switchCamera() async {
    if (cameras.length > 1) {
      selectedCameraIndex = selectedCameraIndex == 0 ? 1 : 0;
      await _initCameraController(cameras[selectedCameraIndex]);
      notifyListeners();
    }
  }

  Future<void> takePicture(BuildContext context) async {
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }

    try {
      XFile picture = await controller!.takePicture();
      print('Picture taken: ${picture.path}');

      final croppedFile = await ImageCropper().cropImage(
        sourcePath: picture.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
            ],
          ),
          WebUiSettings(
            context: context,
            presentStyle: WebPresentStyle.dialog,
            size: const CropperSize(
              width: 520,
              height: 520,
            ),
          ),
        ],
      );

      if (croppedFile != null) {
        context.go('/camera/editingResult', extra: croppedFile);
        _croppedFile = croppedFile;
        notifyListeners();
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
