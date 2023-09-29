import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/presentation/views/course_contents_view.dart';
import '../../core/utils/themes.dart';
import '../../core/utils/assets.dart';

class CourseThumbnailView extends StatefulWidget {
  final String subTitle;
  final String mainTitle;
  CourseThumbnailView({Key? key, required this.subTitle, required this.mainTitle}): super(key:key);

  @override
  State<CourseThumbnailView> createState() => _CourseThumbnailViewState();
}

class _CourseThumbnailViewState extends State<CourseThumbnailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: SizeOf.w_lg,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading:  IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false, 
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Images.COURSE_IMG.path),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeOf.w_lg,
              vertical: SizeOf.h_lg,
            ),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("A근처 촬영지 코스",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .apply(
                  color: ColorOf.white.light,
                ),
              ),
              Text("영화로 둘러보는 무산",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .apply(
                  color: ColorOf.white.light,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CourseContentsView(),
                          ),
                        );
                      },
                      color: Colors.white,
                      icon: Icon(Icons.double_arrow_rounded))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
