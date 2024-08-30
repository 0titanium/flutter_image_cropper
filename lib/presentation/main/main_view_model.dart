import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/data/image_data_source.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class MainViewModel extends ChangeNotifier {
  final ImageDataSource _imageDataSource;

  MainViewModel({
    required ImageDataSource imageDataSource,
  }) : _imageDataSource = imageDataSource;

  // vars firebase storage
  List<String> _imageUrls = [];

  List<String> get imageUrls => _imageUrls;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // vars pick image & crop image
  File? _image;
  CroppedFile? _croppedFile;

  File? get image => _image;

  CroppedFile? get croppedFile => _croppedFile;

  // about firebase storage
  void loadImages() async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<String> urlList = await _imageDataSource.getImageListAll();

      _imageUrls = urlList;
    } catch (e) {
      // 에러 처리
      print('Error loading images: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // about pick image & crop image
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
      notifyListeners();
    }
  }

  Future<void> pickImageFromPhoto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      cropImage();
      notifyListeners();
    }
  }

  Future<void> cropImage() async {
    if (_image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
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
        ],
      );
      if (croppedFile != null) {
        // context.go('/album/editingResult', extra: croppedFile);
        _croppedFile = croppedFile;
        notifyListeners();
      }
    }
  }
}
