import 'package:flutter/material.dart';

import 'package:slate/core/utils/themes.dart';

class ImageInfoView extends StatefulWidget {
  final String imageUrl;

  const ImageInfoView({
    super.key,
    required this.imageUrl,
  });

  @override
  State<ImageInfoView> createState() => _ImageInfoViewState();
}

class _ImageInfoViewState extends State<ImageInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: SizeOf.w_md),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                size: 30,
                color: ColorOf.white.light,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Image(
          image: NetworkImage(widget.imageUrl),
          fit: BoxFit.cover,
          frameBuilder: (
            BuildContext context,
            Widget child,
            int? frame,
            bool wasSynchronouslyLoaded,
          ) {
            if (wasSynchronouslyLoaded || frame != null) {
              return child;
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
