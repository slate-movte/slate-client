// code	status
// 200	성공
// 300	요청 완료를 위해 추가 작업 조치 필요
// 400	API 스펙에 맞지 않는 요청을 한 경우 (노션 참고) - 클라 잘못

// 401	비인증 → 서버에서 누구인지 모름
// JWT .. 카카오 로그인 idToken
// 403	비인가 → 서버에서 누구인지 알고 있음(클라받을일없음)
// 404	리소스 없음

// 500	내부 서버 오류 → 백엔드 잘못

class ServerException implements Exception {}

class CacheException implements Exception {}

class PermissionException implements Exception {}

class LocationNotLoadedException implements PermissionException{}

class CameraNotFoundException implements CacheException {}

class CameraControlException implements CacheException {}

class TakePictureException implements CacheException {}

class SavePictureException implements CacheException {}

class KakaoOAuthException implements CacheException {}
