import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert' as json;
import '../infras/database/mariadb_db_configuration.dart';
import '../infras/security/security_service.dart';
import './api.dart';

class APILogin extends API {
  final SecurityService _securityService;
  APILogin(this._securityService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.post('/login', ((Request request) async {
      String body = await request.readAsString();
      Map<String, dynamic> jsonBody = json.jsonDecode(body);
      String username = jsonBody["username"];
      String password = jsonBody["password"];
      var connection = await MariadbDbConfiguration().connection;

      var query = await connection.query(
          "SELECT username, password FROM organiza_usuarios s WHERE username = '$username' AND password = '$password'");

      if (query.isEmpty) {
        return Response.forbidden("lul");
      }

      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);
      connection.close();
      return Response.ok('{"key":"$token"}');
    }));

    router.get('/login', ((Request request) {
      return Response.ok("OK");
    }));

    return createHandler(router: router, middlewares: middlewares);
  }
}
