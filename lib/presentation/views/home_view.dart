import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/profile_view.dart';
import 'package:slate/presentation/views/search_view.dart';
import 'package:slate/presentation/views/searched_item_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool viewOption = true;

  final List<SearchedItemView> _searchViewOptions = <SearchedItemView>[
    ItemListView([]),
    ItemMapView([]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('SLATE'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileView(),
                ),
              );
            },
            icon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 70.h),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeOf.w_lg,
              vertical: SizeOf.h_lg,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: Key('TEXT_FIELD_KEY'),
                  child: Material(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        labelText: '검색어를 입력해주세요.',
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchView(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ActionChip(
        avatar: Icon(viewOption ? Icons.map : Icons.list),
        label: Text(viewOption ? '지도로 보기' : '목록보기'),
        backgroundColor: ColorOf.white.light,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        shape: StadiumBorder(),
        elevation: 0.6,
        onPressed: () {
          setState(() {
            viewOption = !viewOption;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _searchViewOptions.elementAt(viewOption ? 0 : 1),
    );
  }
}
