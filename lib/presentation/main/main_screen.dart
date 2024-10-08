import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/presentation/main/main_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Images'),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.pickImage('album');
            },
            icon: const Icon(Icons.photo_album),
          ),
          IconButton(
            onPressed: () {
              viewModel.pickImage('takingPhoto');
            },
            icon: const Icon(Icons.add_a_photo),
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: viewModel.imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    context.go('/resultDetail',
                        extra: viewModel.cachedImageFiles[index]);
                  },
                  child: Image.file(
                    viewModel.cachedImageFiles[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}
