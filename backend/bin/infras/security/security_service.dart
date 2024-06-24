import 'package:shelf/shelf.dart';

abstract class SecurityService<T> {
  Future<String> generateJWT(String userdId);
  Future<T?> validateJWT(String token);

  Middleware get verifyJWT;
  Middleware get addJWTAuthorization;
}
