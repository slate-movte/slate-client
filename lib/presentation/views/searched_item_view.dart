import 'package:flutter/material.dart';
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
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
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          color: Colors.amber,
                        ),
                        Text('text area'),
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
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: 3,
    );
  }
}
