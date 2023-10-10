class ServerException implements Exception {}

class CacheException implements Exception {}

class PermissionException implements Exception {}

class LocationNotLoadedException implements PermissionException {}

class CameraNotFoundException implements CacheException {}

class CameraControlException implements CacheException {}

class TakePictureException implements CacheException {}

class SavePictureException implements CacheException {}

class LocationException implements Exception {}

class MapException implements Exception {}

class ApiException implements Exception {}
