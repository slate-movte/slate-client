import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';

abstract class AuthNativeDateSource {
  Future<int> getKakaoUserId();
}

class AuthNativeDataSourceImpl implements AuthNativeDateSource {
  @override
  Future<int> getKakaoUserId() async {
    try {
      AccessTokenInfo tokenInfo = await UserApi.instance.accessTokenInfo();
      return tokenInfo.id!;
    } catch (e) {
      throw KakaoException(e.toString());
    }
  }
}
