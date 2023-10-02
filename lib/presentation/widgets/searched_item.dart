import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/core/utils/themes.dart';

class SearchedItem extends StatelessWidget {
  TravelType type;
  String title;
  String? movieInfo;
  String? subTitle;
  String? phone;
  List<String> tag;
  String? actors;
  String? image;
  final Function()? function;

  SearchedItem({
    super.key,
    this.function,
    required this.type,
    required this.title,
    this.actors,
    this.movieInfo,
    this.subTitle,
    this.phone,
    this.tag = const ['수훈비빔밥', '수훈쌈밥'],
    this.image,
  });

  String _typeConvertor() {
    switch (type) {
      case TravelType.RESTAURANT:
        return '음식점';
      case TravelType.ACCOMMODATION:
        return '숙소';
      case TravelType.ATTRACTION:
        return '관광지';
      case TravelType.MOVIE_LOCATION:
        return '영화';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeOf.w_lg,
          vertical: SizeOf.h_lg,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Container(
                  margin: EdgeInsets.only(right: SizeOf.w_lg),
                  width: MediaQuery.of(context).size.width/2,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: SizeOf.w_sm,
                        ),
                        Text(
                          _typeConvertor(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Visibility(
                    visible: subTitle != null,
                    child: Container(
                      width: 170.w,
                      child: Text(
                        subTitle ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: movieInfo != null,
                    child: Container(
                      width: 170.w,
                     child: Text(
                          movieInfo ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                    ),
                  ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Visibility(
                    visible: actors != null,
                    child: Container(
                      width: 170.w,
                      child:
                        Text(
                          actors ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                    ),
                  ),
                  Visibility(
                    visible: type == TravelType.RESTAURANT,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: tag
                            .map(
                              (tag) => Padding(
                            padding: EdgeInsets.only(right: SizeOf.w_sm),
                            child: Chip(
                              label: Text(tag),
                              labelPadding: EdgeInsets.all(0),
                              visualDensity: VisualDensity(
                                horizontal: 0.0,
                                vertical: -4,
                              ),
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    )
                  ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Visibility(
                    visible: phone != null,
                    child: Container(
                      width: 170.w,
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16.sp,
                            color: ColorOf.grey.light,
                          ),
                          SizedBox(
                            width: SizeOf.w_sm,
                          ),
                          Text(
                            phone ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )
                  )
                ],
              ),
            ),
            Visibility(
              visible: image != null,
                child: Image(
                image: NetworkImage(
                  image!,
                ),
                width: 120.h,
                height: 120.h,
                fit: BoxFit.fill,
                errorBuilder: (context, exception, stackTrace) {
                  return Container(
                    width: 120.h,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: ColorOf.lightGrey.light
                    ),
                    child: Text('Empty Image',textAlign: TextAlign.center,),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
