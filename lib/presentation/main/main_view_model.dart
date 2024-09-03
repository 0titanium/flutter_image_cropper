import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/core/crop_image/crop_image_service.dart';
import 'package:flutter_image_cropper/core/image_caching/ImageCachingService.dart';
import 'package:flutter_image_cropper/data/image_data_source.dart';
import 'package:image_picker/image_picker.dart';

class MainViewModel extends ChangeNotifier {
  final ImageDataSource _imageDataSource;
  final CropImageService _cropImageService;
  final ImageCachingService _imageCachingService;

  MainViewModel({
    required ImageDataSource imageDataSource,
    required CropImageService cropImageService,
    required ImageCachingService imageCachingService,
  })  : _imageDataSource = imageDataSource,
        _cropImageService = cropImageService,
        _imageCachingService = imageCachingService {
    loadImages();
  }

  List<File> _cachedImageFiles = [];

  List<File> get cachedImageFiles => _cachedImageFiles;

  // vars firebase storage
  List<String> _imageUrls = [];

  List<String> get imageUrls => _imageUrls;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // vars pick image & crop image
  File? _image;

  // about firebase storage
  void loadImages() async {
    _isLoading = true;
    notifyListeners();

    try {
      final List<String> urlList = await _imageDataSource.getImageListAll();

      _cachedImageFiles = await Future.wait(
          urlList.map((url) => _imageCachingService.getCachedImage(url)));

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
  Future<void> pickImage(String types) async {
    final pickedFile = types == 'album'
        ? await ImagePicker().pickImage(source: ImageSource.gallery)
        : await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      await cropImage();
      notifyListeners();
    }
  }

  Future<void> cropImage() async {
    if (_image != null) {
      final croppedFile = await _cropImageService.cropImage(_image!);

      if (croppedFile != null) {
        final newImageUrl = await _imageDataSource.saveImage(croppedFile);

        if (newImageUrl != null) {
          _imageUrls.add(newImageUrl);

          final cachedFile =
              await _imageCachingService.getCachedImage(newImageUrl);

          _cachedImageFiles.add(cachedFile);

          notifyListeners();
        }
      }
    }
  }
}
