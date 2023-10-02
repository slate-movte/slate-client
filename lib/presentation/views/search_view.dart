import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/bloc/search/search_bloc.dart';
import 'package:slate/presentation/bloc/search/search_event.dart';
import 'package:slate/presentation/bloc/search/search_state.dart';
import 'package:slate/presentation/views/searched_item_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool viewOption = true;
  TextEditingController controller = TextEditingController();
  int movieLastId = 0;
  int attractionLastId = 0;

  @override
  void initState() {
    context.read<SearchBloc>().add(
          KeywordSearchEvent(
            keyword: "",
            movieLastId: movieLastId,
            attractionLastId: attractionLastId,
          ),
        );
    super.initState();
  }

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
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                  controller: controller,
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
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is KeywordDataLoaded) {
            state.dataList.map((e) => log(e.toString()));

            return ItemListView(items: state.dataList);
          } else if (state is SearchError) {
            return Text("ERROR");
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
