import 'package:camera/camera.dart';
import 'package:slate/core/errors/exceptions.dart';

abstract class CameraNativeDataSource {
  Future<CameraController> getCameraControllerWithInitialized();
  Future<XFile> getImageAfterTakePicture(CameraController controller);
}

class CameraNativeDataSourceImpl implements CameraNativeDataSource {
  @override
  Future<CameraController> getCameraControllerWithInitialized() async {
    try {
      List<CameraDescription> camera = await availableCameras();
      if (camera.isEmpty) {
        throw CameraNotFoundException();
      }
      CameraController controller = CameraController(
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

  @override
  Future<XFile> getImageAfterTakePicture(CameraController controller) async {
    try {
      return await controller.takePicture();
    } catch (e) {
      throw TakePictureException();
    }
  }
}
