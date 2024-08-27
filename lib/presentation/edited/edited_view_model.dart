import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class EditedViewModel extends ChangeNotifier {
  List<String> _imageUrls = [];

  List<String> get imageUrls => _imageUrls;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> loadImages() async {
    _isLoading = true;
    notifyListeners();

    try {
      final ListResult result =
          await FirebaseStorage.instance.ref('images').listAll();

      final List<String> urlList = await Future.wait(
        result.items.map((ref) => ref.getDownloadURL()),
      );

      _imageUrls = urlList.reversed.toList();
    } catch (e) {
      // 에러 처리
      print('Error loading images: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
