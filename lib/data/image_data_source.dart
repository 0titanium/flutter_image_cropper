import 'package:firebase_storage/firebase_storage.dart';

class ImageDataSource {
  Future<List<String>> getImageListAll() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('images').listAll();

    final List<String> urlList = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL()),
    );

    return urlList;
  }
}
