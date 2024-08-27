import 'package:flutter/material.dart';
import 'package:flutter_image_cropper/presentation/edited/edited_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditedScreen extends StatefulWidget {
  const EditedScreen({super.key});

  @override
  State<EditedScreen> createState() => _EditedScreenState();
}

class _EditedScreenState extends State<EditedScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EditedViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edited'),
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
                    context.go('/edited/resultDetail',
                        extra: viewModel.imageUrls[index]);
                  },
                  child: Image.network(
                    viewModel.imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}
