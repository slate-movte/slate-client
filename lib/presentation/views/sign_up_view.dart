import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatefulWidget {
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //1. 프로필
          Stack(
            children: [
              //사진
              Container(
                width: 112.w,
                height: 112.h,
                margin: EdgeInsets.only(top: 50.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.black12, //Color(0x939393),
                    shape: BoxShape.circle),
              ),
              //카메라이모티콘버튼
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 35.w,
                  height: 35.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.black54, //Color(0xEFEFEF)
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.black12,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 51.h,
          ),
          //2. 닉네임
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: Text(
                    "닉네임",
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
                SizedBox(
                    width: 350.w,
                    height: 48.h,
                    child: TextFormField(
                      onChanged: (value) {
                        nickName = value;
                      },
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black12)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black12))),
                      maxLines: 1,
                      cursorColor: Colors.black12,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          //3. 약관동의
          Container(
            margin: EdgeInsets.only(left: 22.w, right: 21.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        minimumSize: Size(351.w, 48.h)),
                    onPressed: () {
                      if (isChecked == false && nickName == "") {
                        setState(() {
                          validMsg = "닉네임을 입력해주세요.";
                        });
                      } else if (isChecked == true && nickName == "") {
                        setState(() {
                          validMsg = "닉네임을 입력해주세요.";
                        });
                      } else if (isChecked == false && nickName != "") {
                        setState(() {
                          validMsg = "약관에 동의해주세요.";
                        });
                      } else {
                        setState(() {
                          validMsg = "";
                        });
                      }
                      print(isChecked);
                    },
                    child: Text(
                      "다음 버튼",
                      style: TextStyle(fontSize: 18),
                    )),
              ],
            ),
          )
          //4. 다음 버튼
        ],
      ),
    );
  }
}
