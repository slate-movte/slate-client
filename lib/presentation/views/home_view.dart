import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/themes.dart';
import 'profile_view.dart';
import 'search_view.dart';
import 'searched_item_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                      readOnly: true,
                      autofocus: false,
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
      body: const ItemMapView(),
    );
  }
}
