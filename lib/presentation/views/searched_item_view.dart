import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

abstract class SearchedItemView extends StatefulWidget {
  final List items;

  const SearchedItemView({super.key, required this.items});
}

class ItemMapView extends SearchedItemView {
  final bool initBottomSheet;
  final double? bottomSheetHeight;

  const ItemMapView({
    super.key,
    required super.items,
    this.initBottomSheet = false,
    this.bottomSheetHeight,
  });

  @override
  State<ItemMapView> createState() => _ItemMapViewState();
}

class _ItemMapViewState extends State<ItemMapView> {
  @override
  void initState() {
    if (widget.initBottomSheet) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        openBottomSheet(context);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorOf.black.light,
      body: Center(
        child: IconButton(
          onPressed: () async => await openBottomSheet(context),
          icon: Icon(
            Icons.pin_drop_outlined,
            color: ColorOf.white.light,
          ),
        ),
      ),
    );
  }

  Future openBottomSheet(BuildContext context) async {
    showBottomSheet(
      elevation: 1,
      context: context,
      builder: (context) {
        return SizedBox(
          height: widget.bottomSheetHeight ?? 550.h,
          child: ItemTable(
            header: ItemHeader(
              header: Text(
                '수훈식당',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                )
              ],
            ),
            sections: [
              ItemSection(
                padding: EdgeInsets.zero,
                builder: ItemSectionBuilder()
                  ..address = const ItemTableRow(
                    title: '주소',
                    body: '부산 수영구 광안로 61번가길 32 2층',
                  )
                  ..phone = ItemTableRow(
                    title: '전화번호',
                    body: '0507-1367-1753',
                    bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                  )
                  ..hours = const ItemTableRow(
                    title: '영업시간',
                    body: '''월요일 09:00~21:00
화요일 09:00~21:00
수요일 09:00~21:00
목요일 09:00~21:00
금요일 09:00~21:00
토요일 09:00~21:00
일요일 정기휴무''',
                  )
                  ..info = const ItemTableRow(
                    title: '식당정보',
                    body: '수훈비빔밥과 수훈쌈밥이 맛있는 부산 맛집!',
                  )
                  ..homePage = ItemTableRow(
                    title: '홈페이지',
                    body: 'www.soooohoooooon.co.kr',
                    bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
              ),
              ItemSection(
                builder: ItemSectionBuilder()..image = const ItemTableGrid(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemListView extends SearchedItemView {
  const ItemListView({super.key, required super.items});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SearchedItem(
          function: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => index % 2 == 0
                  ? const ItemInfoView()
                  : const MovieInfoView(), // example
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 3,
    );
  }
}
