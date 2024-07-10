import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert' as json;
import '../models/model_user.dart';
import '../infras/security/security_service.dart';
import './api.dart';
import '../services/service_login.dart';

class APILogin extends API {
  final SecurityService _securityService;
  final ServiceLogin _loginService;
  APILogin(this._securityService, this._loginService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true}) {
    Router router = Router();

    router.post('/login', ((Request request) async {
      String body = await request.readAsString();
      Map<String, dynamic> jsonBody = json.jsonDecode(body);
      String username = jsonBody["username"];
      String password = jsonBody["password"];

      ModelUser? user = await _loginService.readOneLogin(username, password);

      if (user == null) {
        return Response.unauthorized("Wrong Username or Password");
      }

      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);
      return Response.ok('{"id":${user.id}, "username": "${user.username}"}');
    }));

    router.get('/login', ((Request request) {
      return Response.ok("OK");
    }));

    return createHandler(
        router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
