import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/searched_item_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool viewOption = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Hero(
          tag: const Key('TEXT_FIELD_KEY'),
          child: Container(
            color: Colors.amber,
            child: Material(
              child: SizedBox(
                height: 48.h,
                width: 314.w,
                child: TextField(
                  autofocus: true,
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    labelText: '검색어를 입력해주세요.',
                  ),
                ),
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, SizeOf.h_sm),
          child: const SizedBox(),
        ),
      ),
      body: const ItemListView(),
    );
  }
}
