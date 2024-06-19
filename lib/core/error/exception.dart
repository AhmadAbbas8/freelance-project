import 'default_response.dart';

class ServerException implements Exception {
  final DefaultResponse errorModel;

  ServerException({required this.errorModel});
}

class OfflineException implements Exception {

}

class EmptyCacheException implements Exception {}
