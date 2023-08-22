import 'package:flutter/material.dart';
import 'package:slate/presentation/widgets/item_table.dart';

class ItemInfoView extends StatefulWidget {
  const ItemInfoView({super.key});

  @override
  State<ItemInfoView> createState() => _ItemInfoViewState();
}

class _ItemInfoViewState extends State<ItemInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('수훈식당'),
      ),
      body: Center(
        child: ItemTable(
          header: ItemHeader(
            header: Text(
              '수훈식당',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          sections: [
            ItemSection(
              padding: EdgeInsets.zero,
              builder: ItemSectionBuilder()
                ..address = ItemTableRow(
                  title: '주소',
                  body: '부산 수영구 광안로 61번가길 32 2층',
                )
                ..phone = ItemTableRow(
                  title: '전화번호',
                  body: '0507-1367-1753',
                  bodyTextStyle: Theme.of(context).textTheme.bodySmall,
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
                  bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                ),
            ),
            ItemSection(
              builder: ItemSectionBuilder()..image = ItemTableGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
