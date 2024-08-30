import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_cropper/data/image_data_source.dart';

class MainViewModel extends ChangeNotifier {
  final ImageDataSource _imageDataSource;

  MainViewModel({
    required ImageDataSource imageDataSource,
  }) : _imageDataSource = imageDataSource;

  List<String> _imageUrls = [];

  List<String> get imageUrls => _imageUrls;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadImages() async {
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
}
