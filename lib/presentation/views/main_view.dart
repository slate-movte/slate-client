import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/bloc/scene/scene_bloc.dart';
import 'package:slate/presentation/bloc/scene/scene_state.dart';

import 'camera_view.dart';
import 'course_view.dart';
import 'home_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static const List<Widget> _viewList = <Widget>[
    HomeView(),
    SizedBox(),
    CourseView(),
  ];

  void _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _viewList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 125.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 25,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 36.h,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: BlocBuilder<SceneBloc, SceneState>(
                builder: (context, state) {
                  return FloatingActionButton(
                    elevation: 0,
                    backgroundColor: state is SceneSelected
                        ? ColorOf.point.light
                        : ColorOf.black.light,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraView(
                            selectedMovieTitle: state is SceneSelected
                                ? state.movieTitle
                                : null,
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.camera_alt_outlined),
                  );
                },
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map_outlined,
                size: 36.h,
              ),
              label: 'Course',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
