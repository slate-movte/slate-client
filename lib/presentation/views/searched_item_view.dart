import 'package:flutter/material.dart';
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

abstract class SearchedItemView extends StatelessWidget {
  final List items;

  SearchedItemView({super.key, required this.items});
}

class ItemMapView extends SearchedItemView {
  ItemMapView(List items, {super.key}) : super(items: items);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                builder: (context) {
                  return SizedBox(
                    height: 600,
                    child: ItemTable(
                      header: ItemHeader(
                        header: Text(
                          '수훈식당',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      sections: [
                        ItemSection(
                          builder: ItemSectionBuilder()
                            ..address = ItemTableRow(
                              title: '주소',
                              body: '부산 수영구 광안로 61번가길 32 2층',
                            )
                            ..phone = ItemTableRow(
                              title: '전화번호',
                              body: '0507-1367-1753',
                              bodyTextStyle:
                                  Theme.of(context).textTheme.bodySmall,
                            )
                            ..hours = ItemTableRow(
                              title: '영업시간',
                              body: '''월요일 09:00~21:00
화요일 09:00~21:00
수요일 09:00~21:00
목요일 09:00~21:00
금요일 09:00~21:00
토요일 09:00~21:00
일요일 정기휴무''',
                            )
                            ..info = ItemTableRow(
                              title: '식당정보',
                              body: '수훈비빔밥과 수훈쌈밥이 맛있는 부산 맛집!',
                            )
                            ..info = ItemTableRow(
                              title: '홈페이지',
                              body: 'www.soooohoooooon.co.kr',
                              bodyTextStyle:
                                  Theme.of(context).textTheme.bodySmall,
                            ),
                        ),
                        ItemSection(
                          builder: ItemSectionBuilder()
                            ..image = ItemTableGrid(),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('modal test'),
          ),
        ],
      ),
    );
  }
}

class ItemListView extends SearchedItemView {
  ItemListView(List items, {super.key}) : super(items: items);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SearchedItem(
          function: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ItemInfoView(),
              // builder: (context) => MovieInfoView(),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: 3,
    );
  }
}
