import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/presentation/bloc/camera/camera_bloc.dart';
import 'package:slate/presentation/bloc/camera/camera_event.dart';
import 'package:slate/presentation/bloc/camera/camera_state.dart';

class DisplayPictureView extends StatelessWidget {
  final XFile image;

  const DisplayPictureView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('저장하기'),
      ),
      body: SafeArea(
        child: BlocListener<CameraBloc, CameraState>(
          listener: (context, state) {
            if (state is SavePictureOn) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    backgroundColor: Colors.transparent,
                    title: Center(child: CircularProgressIndicator()),
                  );
                },
              );
            }
            if (state is SavePictureDone) {
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Flexible(
                child: Image.file(
                  File(image.path),
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt_outlined),
                title: Text('촬영하기'),
                subtitle: Text('사진 다시 촬영'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.save_alt_rounded),
                title: Text('저장하기'),
                subtitle: Text('기기에서 사진 저장'),
                onTap: () async {
                  context
                      .read<CameraBloc>()
                      .add(SavePictureEvent(image: image));
                },
              ),
              // Divider(),
              // ListTile(
              //   leading: Icon(Icons.ios_share_outlined),
              //   title: Text('공유하기'),
              //   subtitle: Text('외부로 사진 공유'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
