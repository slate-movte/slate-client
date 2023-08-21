import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/widgets/item_table.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String nickName = "";
  TextEditingController nicknameController = TextEditingController();
  bool isChecked = false;
  String validMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Badge(
                child: CircleAvatar(
                  radius: 56,
                  backgroundColor: ColorOf.grey.light,
                ),
                label: Icon(
                  Icons.camera_alt,
                  color: ColorOf.white.light,
                ),
                alignment: Alignment.bottomRight,
                largeSize: 35.h,
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                backgroundColor: ColorOf.point.light,
                offset: const Offset(0, 0),
              ),
              Spacer(),
              SizedBox(
                height: 300.h,
                child: ItemTable(
                  physics: NeverScrollableScrollPhysics(),
                  backgroundColor: ColorOf.white.light,
                  sections: [
                    ItemSection.onlyPost(
                      builder: ItemSectionBuilder()
                        ..posts = [
                          ItemTablePost(
                            title: '닉네임',
                            titleStyle: Theme.of(context).textTheme.titleSmall,
                            textBody: false,
                            body: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorOf.lightGrey.light),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorOf.lightGrey.light),
                                ),
                              ),
                              maxLines: 1,
                              cursorColor: ColorOf.grey.light,
                            ),
                          ),
                          ItemTablePost(
                            title: '이용약관',
                            titleStyle: Theme.of(context).textTheme.titleSmall,
                            textBody: false,
                            body: Container(
                              width: 350.w,
                              height: 139.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeOf.w_md,
                                vertical: SizeOf.h_md,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: ColorOf.lightGrey.light),
                                borderRadius: BorderRadius.circular(
                                  SizeOf.r,
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  "제1조(개인정보의 처리목적) \n① 슬레이트는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.",
                                ),
                              ),
                            ),
                          ),
                        ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: ColorOf.black.light,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    "동의합니다.",
                    style: Theme.of(context).textTheme.labelLarge,
                  )
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: SizeOf.h_md),
                child: Text(
                  '닉네임을 입력하세요.',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeOf.w_lg),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('시작하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
