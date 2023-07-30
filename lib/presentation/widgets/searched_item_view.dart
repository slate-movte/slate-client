import 'package:flutter/material.dart';

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
            onPressed: () {},
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
        return ListTile(
          title: Text('item $index'),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: 3,
    );
  }
}
