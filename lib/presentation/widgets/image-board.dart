import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageBoard extends StatelessWidget {

  // String contentType; // 영화, 가게, 가게(사진X) -> 처음에 타입을 구분한 뒤에 분기 처리를 해야할까요?

  final String title;
  final String subtitle; //영화(년도), 식당유형

  bool isName;
  Widget? actorLabels;

  bool isPhoto;
  Widget? photoCarousel;

  bool isDistance;
  Widget? distanceTxt;

  ImageBoard({
    super.key,
    required this.title,
    required this.subtitle,
    this.isName = false,
    this.actorLabels,
    this.isPhoto = false,
    this.photoCarousel,
    this.isDistance = false,
    this.distanceTxt
  });
  //: assert(photoCarousel == null || existPhoto,
  //'Trailing wideget is only available when onTrailing is true.');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title),
            Text(subtitle)
          ],
        ),
        //이름 태그
        Visibility(
          visible: isName,
          child: actorLabels ?? SizedBox()
        ),
        //거리&주소
        Visibility(
          visible: isDistance,
            child: distanceTxt ?? SizedBox()
        ),
        //사진캐러샐
        Visibility(
            visible : isPhoto,
            child: photoCarousel ?? SizedBox()),

      ],
    );
  }
}
