import 'package:flutter_image_cropper/presentation/album/album_screen.dart';
import 'package:flutter_image_cropper/presentation/camera/camera_screen.dart';
import 'package:flutter_image_cropper/presentation/edited/edited_screen.dart';
import 'package:flutter_image_cropper/presentation/editing/editing_screen.dart';
import 'package:flutter_image_cropper/presentation/main/main_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const MainScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'album',
          builder: (context, state) {
            return const AlbumScreen();
          },
        ),
        GoRoute(
          path: 'editing',
          builder: (context, state) {
            return const EditingScreen();
          },
        ),
        GoRoute(
          path: 'camera',
          builder: (context, state) {
            return const CameraScreen();
          },
        ),
        GoRoute(
          path: 'edited',
          builder: (context, state) {
            return const EditedScreen();
          },
        ),
      ],
    ),
  ],
);
