import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slate/core/utils/themes.dart';

class ItemSectionBuilder {
  ItemTableRow? address;
  ItemTableRow? phone;
  ItemTableRow? hours;
  ItemTableRow? info;
  ItemTableRow? homePage;
  ItemTableGrid? image;
  List<ItemTablePost>? posts;

  @override
  String toString() {
    return 'address : $address, phone: $phone, hours: $hours, info: $info, homePage: $homePage, post: ${(posts ?? []).toList()}';
  }
}

abstract class ItemElement extends StatelessWidget {
  const ItemElement({super.key});
}

class ItemSection extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final List<ItemElement?> items = [];

  ItemSection({
    super.key,
    required ItemSectionBuilder builder,
    this.padding,
  }) {
    // log(builder.toString());
    items.addAll([
      builder.address,
      builder.phone,
      builder.hours,
      builder.info,
      builder.homePage,
      builder.image,
    ]);
  }

  ItemSection.onlyPost({
    super.key,
    required ItemSectionBuilder builder,
    this.padding,
  }) {
    items.addAll(
      builder.posts ?? [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorOf.white.light,
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: SizeOf.w_lg,
            vertical: SizeOf.h_lg,
          ),
      child: Column(
        children: items.nonNulls.toList(),
      ),
    );
  }
}

class ItemTable extends ItemElement {
  final ItemHeader? header;
  final List<ItemSection> sections;
  final ScrollPhysics? physics;
  final Color? backgroundColor;

  final List<Widget> _slivers = [];

  ItemTable({
    super.key,
    this.header,
    this.physics,
    this.backgroundColor,
    this.sections = const [],
  }) {
    List<Widget> sections = [];

    for (int i = 0; i < this.sections.length; i++) {
      sections.add(this.sections[i]);
      if (i != this.sections.length - 1) {
        sections.add(SizedBox(height: SizeOf.h_md));
      }
    }
    _slivers.add(SliverList(
      delegate: SliverChildListDelegate(sections),
    ));
    if (header != null) _slivers.insert(0, header!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? ColorOf.lightGrey.light,
      child: CustomScrollView(
        physics: physics,
        slivers: _slivers,
      ),
    );
  }
}

class ItemHeader extends StatelessWidget {
  final Widget? header;
  final Widget? flexibleSpace;
  final double? height;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool forceElevated;

  const ItemHeader({
    super.key,
    this.header,
    this.flexibleSpace,
    this.height,
    this.backgroundColor,
    this.actions,
    this.forceElevated = false,
  }) : assert(flexibleSpace == null || height != null,
            'height must have a value if flexibleSpace provided');

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      title: header,
      backgroundColor: backgroundColor ?? ColorOf.lightGrey.light,
      centerTitle: false,
      pinned: true,
      collapsedHeight: height,
      expandedHeight: height,
      flexibleSpace: flexibleSpace,
      titleSpacing: SizeOf.w_lg,
      actions: actions,
      elevation: 1,
      forceElevated: forceElevated,
    );
  }
}

class ItemTablePost extends ItemElement {
  final String title;
  final String content;
  final bool textBody;
  final Widget body;
  final TextStyle? titleStyle;

  const ItemTablePost({
    super.key,
    required this.title,
    this.content = '',
    this.textBody = true,
    this.titleStyle,
    this.body = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: SizeOf.h_lg),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle ?? Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: SizeOf.h_sm),
          textBody
              ? Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : body,
        ],
      ),
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
      padding: EdgeInsets.symmetric(
        horizontal: SizeOf.w_lg,
        vertical: SizeOf.h_sm,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorOf.lightGrey.light,
          ),
        ),
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
    );
  }
}

class ItemTableGrid extends ItemElement {
  const ItemTableGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
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
    );
  }
}
