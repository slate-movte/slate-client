import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/presentation/widgets/searched_item_view.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  static List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;
  int _selectedIndex = 0;

  final List<SearchedItemView> _searchViewOptions = <SearchedItemView>[
    ItemMapView([]),
    ItemListView([]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Hero(
          tag: Key('TEXT_FIELD_KEY'),
          child: Material(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                labelText: '검색어를 입력해주세요.',
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: Hero(
            tag: Key('TEXT_FIELD_FILTER_KEY'),
            child: Material(
              child: Row(
                children: [
                  DropdownButton<String>(
                    value: list.first,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: list.first,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: list.first,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.list),
        label: Text('목록보기'),
        onPressed: () {
          setState(() {
            _selectedIndex = 1;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _searchViewOptions.elementAt(_selectedIndex),
    );
  }
}
