import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditedScreen extends StatefulWidget {
  const EditedScreen({super.key});

  @override
  State<EditedScreen> createState() => _EditedScreenState();
}

class _EditedScreenState extends State<EditedScreen> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final ListResult result =
        await FirebaseStorage.instance.ref('images').listAll();

    final List<String> urlList = await Future.wait(
      result.items.map((ref) => ref.getDownloadURL()),
    );

    setState(() {
      _imageUrls = urlList.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edited'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              context.go('/edited/resultDetail', extra: _imageUrls[index]);
              debugPrint(_imageUrls[index]);
            },
            // => _showFullImage(context, _imageUrls[index]),
            child: Image.network(
              _imageUrls[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
