import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slate/presentation/bloc/camera_bloc.dart';
import 'package:slate/presentation/bloc/camera_event.dart';
import 'package:slate/presentation/bloc/camera_state.dart';

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
      body: BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CameraGetReady) {
            return CircularProgressIndicator();
          } else if (state is CameraOn) {
            return Stack(
              children: [
                CameraPreview(state.controller),
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
