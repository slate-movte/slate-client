import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/views/main_view.dart';
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
        title: const Text('회원가입'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
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
              const Spacer(),
              SizedBox(
                height: 300.h,
                child: ItemTable(
                  physics: const NeverScrollableScrollPhysics(),
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
                                border: const OutlineInputBorder(),
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
                              child: const SingleChildScrollView(
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
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      "약관동의",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        //color: Color(282828)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Container(
                      width: 350.w,
                      height: 139.h,
                      padding: EdgeInsets.only(
                          top: 17.h, left: 16.w, right: 16.w, bottom: 17.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          "제1조(개인정보의 처리목적) \n① 슬레이트는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 개인정보보호법 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.",
                          style: TextStyle(fontSize: 14),
                        ),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  //동의 체크
                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.deepOrangeAccent,
                          side: BorderSide(width: 1.5, color: Colors.black12),
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Text(
                          "동의합니다.",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 110.h,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      validMsg,
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 17.h, bottom: 17.h),
                      backgroundColor: Colors.black12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      minimumSize: Size(351.w, 48.h),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                      // if (isChecked == false && nickName == "") {
                      //   setState(() {
                      //     validMsg = "닉네임을 입력해주세요.";
                      //   });
                      // } else if (isChecked == true && nickName == "") {
                      //   setState(() {
                      //     validMsg = "닉네임을 입력해주세요.";
                      //   });
                      // } else if (isChecked == false && nickName != "") {
                      //   setState(() {
                      //     validMsg = "약관에 동의해주세요.";
                      //   });
                      // } else {
                      //   setState(() {
                      //     validMsg = "";
                      //   });
                      // }
                      print(isChecked);
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
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MainView()),
                    );
                  },
                  child: const Text('시작하기'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
