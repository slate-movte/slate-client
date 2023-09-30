import 'package:flutter/material.dart';
import 'package:slate/domain/entities/map_item.dart';
import 'package:slate/presentation/views/searched_item_view.dart';

class ItemInfoView extends StatefulWidget {
  final MapItem item;

  const ItemInfoView({super.key, required this.item});

  @override
  State<ItemInfoView> createState() => _ItemInfoViewState();
}

class _ItemInfoViewState extends State<ItemInfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.title),
        centerTitle: false,
      ),
      body: ItemMapView(
        initBottomSheet: true,
        item: widget.item,
      ),
    );
  }
}
