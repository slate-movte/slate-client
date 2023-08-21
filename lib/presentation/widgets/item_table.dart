import 'package:flutter/material.dart';
import 'package:slate/core/utils/themes.dart';

class ItemSectionBuilder {
  ItemTableRow? address;
  ItemTableRow? phone;
  ItemTableRow? hours;
  ItemTableRow? info;
  ItemTableRow? homePage;
  ItemTableGrid? image;
}

abstract class ItemElement extends StatelessWidget {
  const ItemElement({super.key});
}

class ItemSection extends StatelessWidget {
  final List<ItemElement?> items = [];

  ItemSection({
    super.key,
    required ItemSectionBuilder builder,
  }) {
    items.addAll([
      builder.address,
      builder.phone,
      builder.info,
      builder.homePage,
      builder.image,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOf.lightGrey.light,
      child: Column(
        children: items.nonNulls.toList(),
      ),
    );
  }
}

class ItemTable extends ItemElement {
  final ItemHeader? header;
  final List<ItemSection> sections;
  final List<Widget> _list = [];

  ItemTable({
    super.key,
    this.header,
    this.sections = const [],
  }) {
    for (int i = 0; i < sections.length; i++) {
      _list.add(sections[i]);
      if (i != sections.length - 1) {
        _list.add(SizedBox(height: SizeOf.h_md));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOf.lightGrey.light,
      child: CustomScrollView(
        slivers: [
          header ?? const SizedBox.shrink(),
          SliverList(
            delegate: SliverChildListDelegate(_list),
          )
        ],
      ),
    );
  }
}

class ItemHeader extends StatelessWidget {
  final Widget header;

  const ItemHeader({
    super.key,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: header,
      backgroundColor: ColorOf.lightGrey.light,
      centerTitle: false,
      pinned: true,
    );
  }
}

class ItemTableRow extends ItemElement {
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

class ItemTableGrid extends ItemElement {
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
