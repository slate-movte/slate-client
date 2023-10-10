import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/enums.dart';
import '../../core/utils/themes.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/travel.dart';

class SearchedItem extends StatelessWidget {
  final TravelType type;
  final String title;
  final String? movieInfo;
  final String? subTitle;
  final String? phone;
  final List<String> tag;
  final List<String>? actors;
  final String? imageUrl;
  final Function()? function;

  const SearchedItem({
    super.key,
    this.function,
    required this.type,
    required this.title,
    this.actors,
    this.movieInfo,
    this.subTitle,
    this.phone,
    this.imageUrl,
    this.tag = const [],
  });

  factory SearchedItem.movie({
    required Movie movie,
    required Function() function,
  }) {
    return SearchedItem(
      type: TravelType.MOVIE_LOCATION,
      title: movie.title,
      movieInfo:
          '개봉일 ${movie.openDate!.year}.${movie.openDate!.month}.${movie.openDate!.day}',
      imageUrl: movie.posterUrl,
      function: function,
      actors: movie.movieCastList.length > 4
          ? movie.movieCastList.sublist(0, 3)
          : movie.movieCastList,
    );
  }

  factory SearchedItem.travel({
    required Travel travel,
    required Function() function,
  }) {
    return SearchedItem(
      type: travel.type,
      title: travel.title,
      phone: travel.tel,
      tag: travel.menus == null
          ? []
          : travel.menus!.length > 4
              ? travel.menus!.sublist(0, 3)
              : travel.menus!,
      subTitle: travel.address,
      imageUrl: travel.imageUrl,
      function: function,
    );
  }

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
                  Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 140.w),
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
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
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Visibility(
                    visible: subTitle != null,
                    child: SizedBox(
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
                    child: SizedBox(
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
                    child: Row(
                      children: (actors ?? [])
                          .map((actor) => Text('$actor '))
                          .toList(),
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
                                  labelPadding: const EdgeInsets.all(0),
                                  visualDensity: const VisualDensity(
                                    horizontal: 0.0,
                                    vertical: -4,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Visibility(
                    visible: phone != null && phone != "",
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
                ],
              ),
            ),
            Visibility(
              visible: imageUrl != null && imageUrl != "",
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(SizeOf.r)),
                child: Image.network(
                  imageUrl ??
                      "http://tong.visitkorea.or.kr/cms/resource/43/2903043_image2_1.JPG",
                  width: 80.w,
                  height: type == TravelType.MOVIE_LOCATION ? 100.h : 80.h,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
