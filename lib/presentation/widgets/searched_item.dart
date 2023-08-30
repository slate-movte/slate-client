import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';

class SearchedItem extends StatelessWidget {
  final Function()? function;

  const SearchedItem({super.key, this.function});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '수훈식당',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(
                        width: SizeOf.w_sm,
                      ),
                      Text(
                        '음식점',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Text(
                    '부산 수영구 광안로 61번가길 32 2층',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  const Row(
                    children: [
                      Chip(
                        label: Text('수훈 비빔밥'),
                        labelPadding: EdgeInsets.all(0),
                        visualDensity: VisualDensity(
                          horizontal: 0.0,
                          vertical: -4,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeOf.h_sm,
                  ),
                  Row(
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
                        '0507-1367-1753',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Placeholder(
              child: SizedBox(
                height: 83.h,
                width: 83.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
