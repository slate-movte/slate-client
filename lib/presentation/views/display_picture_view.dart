import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureView extends StatelessWidget {
  final String imagePath;

  const DisplayPictureView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('저장하기'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: Image.file(
                File(imagePath),
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
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.ios_share_outlined),
              title: Text('공유하기'),
              subtitle: Text('외부로 사진 공유'),
            ),
          ],
        ),
      ),
    );
  }
}
