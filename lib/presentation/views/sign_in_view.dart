import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:slate/core/utils/assets.dart';
import 'package:slate/core/utils/themes.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Images.APP_LOGO.path,
              width: 212.w,
              height: 85.h,
            ),
            SizedBox(height: 60.h),
            Column(
              children: [
                InkWell(
                  onTap: () async {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (context) => const SignUpView()),
                    // );
                    // String a = await AuthCodeClient.instance.authorizeWithTalk(
                    //   redirectUri: 'https://localhost:8080/oidc/kakao',
                    // );
                    // 카카오 로그인 구현 예제
                    // 카카오톡 실행 가능 여부 확인
                    // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
                    bool a = await isKakaoTalkInstalled();
                    log(a.toString());
                    // UserApi.instance.signup()
                    if (await isKakaoTalkInstalled()) {
                      try {
                        OAuthToken token =
                            await UserApi.instance.loginWithKakaoTalk();
                        // UserApi.instance.signup();
                        log(token.accessToken);
                        log(token.toString());
                        print('카카오톡으로 로그인 성공1');
                        AccessTokenInfo info =
                            await UserApi.instance.accessTokenInfo();
                        log(info.toString());
                        User user = await UserApi.instance.me();

                        log(user.kakaoAccount.toString());
                      } catch (error) {
                        print('카카오톡으로 로그인 실패 $error');

                        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                        if (error is PlatformException &&
                            error.code == 'CANCELED') {
                          return;
                        }
                        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                        try {
                          OAuthToken token2 =
                              await UserApi.instance.loginWithKakaoAccount();
                          log(token2.accessToken);
                          TokenManagerProvider.instance.manager.getToken();
                          print('카카오계정으로 로그인 성공2');
                        } catch (error) {
                          print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    } else {
                      try {
                        OAuthToken token3 =
                            await UserApi.instance.loginWithKakaoAccount();
                        log(token3.accessToken);
                        print('카카오계정으로 로그인 성공3');
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  },
                  child: Image.asset(
                    Images.KAKAO_OAUTH.path,
                    width: 327.w,
                    height: 48.h,
                  ),
                ),
                SizedBox(height: SizeOf.h_sm),
                TextButton(
                  onPressed: () async {
                    // Navigator.of(context).pushReplacement(
                    //   MaterialPageRoute(builder: (context) => const MainView()),
                    // );
                    await UserApi.instance.logout();
                    // await UserApi.instance.unlink();
                  },
                  child: const Text('비회원으로 둘러보기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
