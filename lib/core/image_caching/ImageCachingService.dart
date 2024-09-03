import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ImageCachingService {
  Future<File> getCachedImage(String url) async {
    final cacheDir = await getTemporaryDirectory();
    final fileName = url.split('/').last;
    final file = File('${cacheDir.path}/$fileName');

    if (await file.exists()) {
      return file;
    } else {
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
      return file;
    }
  }
}
