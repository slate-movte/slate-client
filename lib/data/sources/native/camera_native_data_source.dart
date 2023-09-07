import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:slate/core/errors/exceptions.dart';

abstract class CameraNativeDataSource {
  Future<void> checkAvailableCamera();
  Future<CameraController> getCameraControllerWithInitialized(
    bool changeDirection,
  );
  Future<XFile> getImageAfterTakePicture(CameraController controller);
  Future<void> saveXFileImage2LocalGallery(XFile xFile);
}

class CameraNativeDataSourceImpl implements CameraNativeDataSource {
  List<CameraDescription>? cameras;
  CameraController? controller;

  @override
  Future<void> checkAvailableCamera() async {
    try {
      if (cameras == null) {
        cameras = await availableCameras();
        if (cameras!.isEmpty) {
          throw CameraNotFoundException();
        }
      }
    } catch (e) {
      throw CameraControlException();
    }
  }

  @override
  Future<CameraController> getCameraControllerWithInitialized(
    bool changeDirection,
  ) async {
    CameraLensDirection direction;

    try {
      if (controller == null) {
        await checkAvailableCamera();
        direction = CameraLensDirection.back;
      } else {
        if (changeDirection) {
          direction =
              controller!.description.lensDirection == CameraLensDirection.front
                  ? CameraLensDirection.back
                  : CameraLensDirection.front;
        } else {
          await controller!.initialize();
          return controller!;
        }
      }

      CameraDescription camera = cameras!.firstWhere(
        (camera) => camera.lensDirection == direction,
      );
      controller = CameraController(
        camera,
        ResolutionPreset.max,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await controller!.initialize();
      return controller!;
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

  @override
  Future<void> saveXFileImage2LocalGallery(XFile xFile) async {
    try {
      Uint8List imageBytes = await xFile.readAsBytes();
      await ImageGallerySaver.saveImage(imageBytes);
    } catch (e) {
      throw SavePictureException();
    }
  }
}
