import 'package:camera/camera.dart';
import 'package:slate/core/errors/exceptions.dart';

abstract class CameraNativeDataSource {
  Future<CameraController> getCameraControllerWithInitialized();
}

class CameraNativeDataSourceImpl implements CameraNativeDataSource {
  late CameraController controller;

  @override
  Future<CameraController> getCameraControllerWithInitialized() async {
    try {
      List<CameraDescription> camera = await availableCameras();
      if (camera.isEmpty) {
        throw CameraNotFoundException();
      }
      controller = CameraController(
        camera[0],
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await controller.initialize();

      return controller;
    } catch (e) {
      throw CameraControlException();
    }
  }
}
