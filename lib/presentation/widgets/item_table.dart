import 'package:flutter/material.dart';
import 'package:slate/core/utils/themes.dart';

class ItemTableBuilder {
  ItemTableRow? address;
  ItemTableRow? phone;
  ItemTableRow? hours;
  ItemTableRow? info;
  ItemTableRow? homePage;
  ItemTableGrid? image;
}

class ItemTable extends StatelessWidget {
  final String header;
  final ItemTableRow? address;
  final ItemTableRow? phone;
  final ItemTableRow? hours;
  final ItemTableRow? info;
  final ItemTableRow? homePage;
  final ItemTableGrid? image;

  ItemTable({
    super.key,
    required this.header,
    required ItemTableBuilder builder,
  })  : address = builder.address,
        phone = builder.phone,
        hours = builder.hours,
        info = builder.info,
        homePage = builder.homePage,
        image = builder.image;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOf.lightGrey.light,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Text(
              header,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: ColorOf.lightGrey.light,
            centerTitle: false,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              address ?? const SizedBox(),
              phone ?? const SizedBox(),
              hours ?? const SizedBox(),
              info ?? const SizedBox(),
              homePage ?? const SizedBox(),
              SizedBox(height: SizeOf.h_lg),
              image ?? const SizedBox(),
            ]),
          )
        ],
      ),
    );
  }
}

class ItemTableRow extends StatelessWidget {
  final String title;
  final String body;
  final TextStyle? bodyTextStyle;

  const ItemTableRow({
    super.key,
    required this.title,
    this.body = '-',
    this.bodyTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorOf.white.light,
        border: Border(
          top: BorderSide(
            color: ColorOf.lightGrey.light,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeOf.w_lg,
          vertical: SizeOf.h_sm,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(width: SizeOf.w_md),
            Text(
              body,
              style: bodyTextStyle ?? Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class ItemTableGrid extends StatelessWidget {
  const ItemTableGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOf.white.light,
      padding: EdgeInsets.all(SizeOf.h_lg),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1,
        mainAxisSpacing: SizeOf.w_sm / 4,
        crossAxisSpacing: SizeOf.w_sm / 4,
        children: List.generate(11, (index) {
          return Container(
            color: Colors.lightGreen,
            child: Text(' Item : $index'),
          );
        }),
      ),
    );
  }
}
