import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageDataSource {
  Future<List<String>> getImageListAll() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('images').listAll();

    final List<String> urlList = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL()),
    );

    return urlList;
  }

  Future<void> saveImage(CroppedFile? croppedFile) async {
    if (croppedFile == null) return;

    final fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName.jpg');

    try {
      await storageReference.putFile(File(croppedFile.path));
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
