import 'package:flutter_image_cropper/presentation/album/album_screen.dart';
import 'package:flutter_image_cropper/presentation/album/album_view_model.dart';
import 'package:flutter_image_cropper/presentation/camera/camera_screen.dart';
import 'package:flutter_image_cropper/presentation/camera/camera_view_model.dart';
import 'package:flutter_image_cropper/presentation/edited/edited_screen.dart';
import 'package:flutter_image_cropper/presentation/editing/editing_result_screen.dart';
import 'package:flutter_image_cropper/presentation/main/main_screen.dart';
import 'package:flutter_image_cropper/presentation/result_detail/result_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

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
            return ChangeNotifierProvider(
              create: (_) => AlbumViewModel(),
              child: const AlbumScreen(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'editingResult',
              builder: (context, state) {
                return EditingResultScreen(image: state.extra as CroppedFile);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'camera',
          builder: (context, state) {
            return ChangeNotifierProvider(
              create: (_) => CameraViewModel(),
              child: const CameraScreen(),
            );
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'editingResult',
              builder: (context, state) {
                return EditingResultScreen(image: state.extra as CroppedFile);
              },
            ),
          ],
        ),
        GoRoute(
          path: 'edited',
          builder: (context, state) {
            return const EditedScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'resultDetail',
              builder: (context, state) {
                return ResultDetailScreen(imageUrl: state.extra as String);
              },
            )
          ],
        ),
      ],
    ),
  ],
);
