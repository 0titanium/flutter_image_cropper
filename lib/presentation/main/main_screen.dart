import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go('/album');
                      },
                      icon: const Icon(Icons.image),
                    ),
                    const Text('앨범'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go('/camera');
                      },
                      icon: const Icon(Icons.camera_alt),
                    ),
                    const Text('카메라'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {},
        destinations: [
          NavigationDestination(
            icon: IconButton(
              onPressed: () {
                context.go('/');
              },
              icon: const Icon(Icons.edit),
            ),
            label: '편집',
          ),
          NavigationDestination(
            icon: IconButton(
              onPressed: () {
                context.go('/edited');
              },
              icon: const Icon(Icons.image),
            ),
            label: '편집된 이미지',
          ),
        ],
      ),
    );
  }
}
