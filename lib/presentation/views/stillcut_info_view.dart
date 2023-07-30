import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class StillcutInfoView extends StatefulWidget {
  const StillcutInfoView({super.key});

  @override
  State<StillcutInfoView> createState() => _StillcutInfoViewState();
}

class _StillcutInfoViewState extends State<StillcutInfoView> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List imageList = [
    "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg",
    "https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg",
    "https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg",
    "https://cdn.pixabay.com/photo/2015/06/19/20/13/sunset-815270_1280.jpg",
    "https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('해운대', style: TextStyle(color: Colors.black),),
          leading:  IconButton(
              onPressed: () {
                Navigator.pop(context); //뒤로가기
              },
              color: Colors.black,
              icon: Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.transparent,
          elevation: 0.0
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 393.w,
                  height: 230.h,
                  child: sliderWidget(), //Image.assets('Haeundae_poster.jpeg', fit: BoxFit.contain)
                ),
                sliderIndicator(),
                SizedBox(
                  height: 39.h,
                ),
                Container(
                    padding: EdgeInsets.only(left: 22, right: 22, bottom: 100.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("위치",
                              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                            ),
                            GestureDetector(
                              onTap:(){

                              },
                              child: Container(
                                //버튼 크기에 맞춰야 할지 여백에 맞춰야 할지
                                // height: 24.h,
                                // width: 104.w,
                                margin: EdgeInsets.only(left: 8.w),
                                padding: EdgeInsets.only(top: 3.h, bottom: 4.h, left: 5.w, right: 8.w),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on, color: Colors.white,),
                                    Text("지도에서 보기", style: TextStyle(color: Colors.white),),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.deepOrangeAccent,
                                    borderRadius: BorderRadius.all(Radius.circular(4))
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text("ㅁㅁ구 00동",
                          style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text("씬 설명",
                          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text("가나다라마바사아자차카타파하가나다라마바사아자차카타파하",
                          style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                ),
              ])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
      ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.map(
            (imgLink) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    imgLink,
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: false,
        //autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12,
              height: 12,
              margin:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black)
                    .withOpacity(_current == entry.key ? 0.9 : 0.4)
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}


