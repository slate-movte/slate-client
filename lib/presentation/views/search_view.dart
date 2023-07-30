import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  static List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String dropdownValue = list.first;
  int _selectedIndex = 0;

  final List<Widget> _searchViewOptions = <Widget>[
    MapBuilder(),
    SearchedListBuilder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class SearchedListBuilder extends StatelessWidget {
  const SearchedListBuilder({
    super.key,
  });

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

class MapBuilder extends StatelessWidget {
  const MapBuilder({
    super.key,
  });

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
