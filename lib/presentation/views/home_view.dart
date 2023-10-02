import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/assets.dart';
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
  // bool viewOption = true;

  // final List<SearchedItemView> _searchViewOptions = <SearchedItemView>[
  //   ItemMapView(
  //     bottomSheetHeight: 430.h,
  //   ),
  //   const ItemListView(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: SizeOf.w_lg,
        title: Image.asset(
          Images.APP_LOGO.path,
          fit: BoxFit.contain,
          height: 32.h,
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileView(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: SizeOf.w_md),
              child: CircleAvatar(
                radius: 26.r,
                backgroundColor: ColorOf.grey.light,
                backgroundImage: AssetImage(Images.DEFAULT_PROFILE.path),
              ),
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
                  tag: const Key('TEXT_FIELD_KEY'),
                  child: Material(
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        labelText: '검색어를 입력해주세요.',
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchView(),
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
      body: ItemMapView(
        bottomSheetHeight: 430.h,
      ),
      // body: Stack(
      //   children: [
      //     _searchViewOptions.elementAt(viewOption ? 0 : 1),
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: ActionChip(
      //         avatar: Icon(viewOption ? Icons.list : Icons.map),
      //         label: Text(viewOption ? '목록보기' : '지도로 보기'),
      //         backgroundColor: ColorOf.white.light,
      //         labelStyle: Theme.of(context).textTheme.bodyLarge,
      //         shape: const StadiumBorder(),
      //         elevation: 0.6,
      //         onPressed: () {
      //           setState(() {
      //             viewOption = !viewOption;
      //           });
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
