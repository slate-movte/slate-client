import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/themes.dart';

class CourseContentsView extends StatefulWidget {
  @override
  _CourseContentsViewState createState() => _CourseContentsViewState();

}

class _CourseContentsViewState extends State<CourseContentsView> {

  int _currentPage = 0;
  final List<String> pages = ["1", "2", "3"];

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
      body: PageView.builder(
          itemCount: pages.length,
          onPageChanged: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
        itemBuilder: (context, index) {
          return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Images.COURSE_IMG.path),
                ),
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                        (pageIndex) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "${pages[index]} / ${pages.length}",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}