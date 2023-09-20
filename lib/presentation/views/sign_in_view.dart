import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'package:slate/core/utils/assets.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/data/sources/remote/auth_remote_data_source.dart';
import 'package:slate/presentation/views/main_view.dart';
import 'package:slate/presentation/views/sign_up_view.dart';

class SignInView extends StatelessWidget {
  SignInView({super.key});
  AuthRemoteDataSource dataSource = AuthRemoteDataSourceImpl();

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
                    // bool a = await isKakaoTalkInstalled();
                    // log(a.toString());
                    // // UserApi.instance.signup()
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

                        final secureStorage = const FlutterSecureStorage();
                        final AT = token.accessToken;
                        await secureStorage.write(key: "ACCESS_TOKEN", value: AT);

                        String? idToken = token.idToken;
                        print("id토큰" + idToken!);
                        String? nickname = user.kakaoAccount?.profile?.nickname;
                        String? profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;

                        if(idToken!=null){
                          //idToken만 있으면 가입 가능. 닉네임 & 프로필은 null 가능하면 null이면 추후 설정.
                          log("토큰있어서 가입 이동");
                          final data = await dataSource.signUp(idToken, nickname, profileImageUrl);
                          log("토큰데이터" + data.toString());
                        }else{
                          print('idToken값 null 문제');
                        }

                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SignUpView()),
                        );

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

                          AccessTokenInfo info =
                          await UserApi.instance.accessTokenInfo();
                          log(info.toString());
                          User user = await UserApi.instance.me();

                          log(user.kakaoAccount.toString());

                          final secureStorage = const FlutterSecureStorage();
                          final AT = token2.accessToken;
                          await secureStorage.write(key: "ACCESS_TOKEN", value: AT);

                          String? idToken = token2.idToken;
                          print("id토큰" + idToken!);
                          String? nickname = user.kakaoAccount?.profile?.nickname;
                          String? profileImageUrl = user.kakaoAccount?.profile?.profileImageUrl;

                          if(idToken!=null){
                            //idToken만 있으면 가입 가능. 닉네임 & 프로필은 null 가능하면 null이면 추후 설정.
                            log("토큰있어서 가입 이동");
                            final data = await dataSource.signUp(idToken, nickname, profileImageUrl);
                            log("토큰데이터" + data.toString());

                          }else{
                            print('idToken값 null 문제');
                          }

                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SignUpView()),
                          );
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const MainView()),
                    );
                    // await UserApi.instance.logout();
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
