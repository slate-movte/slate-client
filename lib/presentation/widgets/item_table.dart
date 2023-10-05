import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/bloc/scene/scene_bloc.dart';
import 'package:slate/presentation/bloc/scene/scene_event.dart';

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

class ItemHeader extends StatelessWidget {
  final Widget? header;
  final Widget? flexibleSpace;
  final double? collapsedHeight;
  final double? expandedHeight;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final bool forceElevated;
  final bool automaticallyImplyLeading;

  const ItemHeader({
    super.key,
    this.header,
    this.flexibleSpace,
    this.collapsedHeight,
    this.expandedHeight,
    this.backgroundColor = const Color.fromARGB(255, 235, 235, 235),
    this.actions,
    this.forceElevated = false,
    this.automaticallyImplyLeading = false,
  }) : assert(flexibleSpace == null || collapsedHeight != null,
            'height must have a value if flexibleSpace provided');

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: header,
      backgroundColor: backgroundColor,
      centerTitle: false,
      pinned: true,
      collapsedHeight: collapsedHeight,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      titleSpacing: SizeOf.w_lg,
      actions: actions,
      elevation: 1,
      forceElevated: forceElevated,
    );
  }
}

abstract class ItemElement extends StatefulWidget {
  const ItemElement({super.key});
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
  State<ItemTable> createState() => _ItemTableState();
}

class _ItemTableState extends State<ItemTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? ColorOf.lightGrey.light,
      child: CustomScrollView(
        physics: widget.physics,
        slivers: widget._slivers,
      ),
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
  State<ItemTablePost> createState() => _ItemTablePostState();
}

class _ItemTablePostState extends State<ItemTablePost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: SizeOf.h_lg),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: widget.titleStyle ?? Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: SizeOf.h_sm),
          widget.textBody
              ? Text(
                  widget.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : widget.body,
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
  State<ItemTableRow> createState() => _ItemTableRowState();
}

class _ItemTableRowState extends State<ItemTableRow> {
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
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(width: SizeOf.w_md),
          Flexible(
            child: Text(
              widget.body,
              style:
                  widget.bodyTextStyle ?? Theme.of(context).textTheme.bodyLarge,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}

class ItemTableGrid extends ItemElement {
  final String? title;
  final TextStyle? titleStyle;
  final List<String> items;
  final bool inCameraUse;
  final Function()? function;

  ItemTableGrid({
    super.key,
    this.title,
    this.titleStyle,
    this.function,
    this.inCameraUse = true,
    this.items = const [],
  });

  @override
  State<ItemTableGrid> createState() => _ItemTableGridState();
}

class _ItemTableGridState extends State<ItemTableGrid> {
  List<bool> _loadedImages = [];

  @override
  void initState() {
    super.initState();
    _loadedImages = List.filled(widget.items.length, false);
  }

  @override
  Widget build(BuildContext context) {
    bool allImagesLoaded = !_loadedImages.contains(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title != null
            ? Padding(
                padding: EdgeInsets.only(bottom: SizeOf.h_md),
                child: Text(
                  widget.title!,
                  style: widget.titleStyle ??
                      Theme.of(context).textTheme.titleMedium,
                ),
              )
            : const SizedBox.shrink(),
        Stack(
          children: [
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              childAspectRatio: 1 / 1,
              mainAxisSpacing: SizeOf.w_sm / 4,
              crossAxisSpacing: SizeOf.w_sm / 4,
              children: List.generate(widget.items.length, (index) {
                final imageProvider = NetworkImage(widget.items[index]);
                return ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(SizeOf.r)),
                  child: InkWell(
                    onTap: () {
                      if (widget.inCameraUse) {
                        context.read<SceneBloc>().add(
                              SelectedSceneEvent(
                                sceneUrl: widget.items[index],
                              ),
                            );
                        Navigator.pop(context);
                      } else {}
                    },
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      frameBuilder: (
                        BuildContext context,
                        Widget child,
                        int? frame,
                        bool wasSynchronouslyLoaded,
                      ) {
                        if (wasSynchronouslyLoaded || frame != null) {
                          _setImageLoaded(index);
                          return child;
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                );
              }),
            ),
            if (!allImagesLoaded)
              Positioned.fill(
                child: Container(
                  color: ColorOf.white.light,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _setImageLoaded(int index) {
    if (!_loadedImages[index]) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _loadedImages[index] = true;
        });
      });
    }
  }
}
