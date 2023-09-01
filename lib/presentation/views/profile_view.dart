import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/themes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: SizeOf.w_lg),
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Badge(
                      label: Icon(
                        Icons.camera_alt,
                        color: ColorOf.white.light,
                      ),
                      alignment: Alignment.bottomRight,
                      largeSize: 35.h,
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      backgroundColor: ColorOf.point.light,
                      offset: const Offset(0, 0),
                      child: CircleAvatar(
                        radius: 56.r,
                        backgroundColor: ColorOf.grey.light,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: SizeOf.h_lg),
                      child: Text(
                        '김뭅트',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('프로필 편집'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('알림 설정'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('로그아웃'),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text('회원 탈퇴'),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
