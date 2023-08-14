import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/presentation/bloc/camera_bloc.dart';
import 'package:slate/presentation/bloc/camera_event.dart';
import 'package:slate/presentation/bloc/camera_state.dart';
import 'package:slate/presentation/views/display_picture_view.dart';

class SnapshotView extends StatefulWidget {
  const SnapshotView({super.key});

  @override
  State<SnapshotView> createState() => _SnapshotViewState();
}

class _SnapshotViewState extends State<SnapshotView> {
  @override
  void initState() {
    context.read<CameraBloc>().add(CameraOnEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('s'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) async {
          if (state is TakePictureDone) {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureView(
                  imagePath: state.image.path,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CameraGetReady) {
            return CircularProgressIndicator();
          } else if (state is CameraOn) {
            return Stack(
              children: [
                CameraPreview(state.controller),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<CameraBloc>()
                        .add(TakePictureEvent(controller: state.controller));
                  },
                  child: Text('d'),
                ),
              ],
            );
          } else if (state is CameraError) {
            return Text(state.message);
          }
          return Placeholder();
        },
      ),
    );
  }
}
