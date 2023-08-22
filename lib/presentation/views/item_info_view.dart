import 'package:flutter/material.dart';
import 'package:slate/presentation/views/searched_item_view.dart';
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
      body: ItemMapView(
        items: [],
        initBottomSheet: true,
      ),
    );
  }
}
