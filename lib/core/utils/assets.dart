// ignore_for_file: constant_identifier_names

enum Images {
  APP_LOGO(path: 'lib/assets/images/slate_logo.png'),
  KAKAO_OAUTH(path: 'lib/assets/images/kakao_login_large_wide.png');

  const Images({required this.path});

  final String path;
}
