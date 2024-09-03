import 'dart:io';

import 'package:flutter_image_cropper/core/crop_image/crop_image_service.dart';
import 'package:flutter_image_cropper/core/image_caching/ImageCachingService.dart';
import 'package:flutter_image_cropper/data/image_data_source.dart';
import 'package:flutter_image_cropper/presentation/main/main_screen.dart';
import 'package:flutter_image_cropper/presentation/main/main_view_model.dart';
import 'package:flutter_image_cropper/presentation/result_detail/result_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MainViewModel(
            imageDataSource: ImageDataSource(),
            cropImageService: CropImageService(),
            imageCachingService: ImageCachingService(),
          ),
          child: const MainScreen(),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'resultDetail',
          builder: (context, state) {
            return ResultDetailScreen(image: state.extra as File);
          },
        ),
      ],
    ),
  ],
);
