import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
      ),
      body: Center(
        child: Column(
          children: [
            _profileBuilder(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
              ),
              onPressed: () {},
              child: Text('텍스트 편집'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
              ),
              onPressed: () {},
              child: Text('텍스트 편집'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
              ),
              onPressed: () {},
              child: Text('텍스트 편집'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
              ),
              onPressed: () {},
              child: Text('텍스트 편집'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileBuilder() {
    return Column(
      children: [
        CircleAvatar(),
        Text('김뭅트'),
      ],
    );
  }
}
