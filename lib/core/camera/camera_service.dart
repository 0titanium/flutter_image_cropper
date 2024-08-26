import 'package:camera/camera.dart';

class CameraService {
  List<CameraDescription>? _cameras;

  Future<List<CameraDescription>> getCameras() async {
    _cameras ??= await availableCameras();
    return _cameras!;
  }
}
