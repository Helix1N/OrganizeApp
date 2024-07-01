import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert' as json;
import '../infras/database/mariadb_db_configuration.dart';
import '../infras/security/security_service.dart';
import './api.dart';

class APISignUp extends API {
  final SecurityService _securityService;
  APISignUp(this._securityService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.post('/signup', ((Request request) async {
      String body = await request.readAsString();
      Map<String, dynamic> jsonBody = json.jsonDecode(body);
      String email = jsonBody["email"];
      String username = jsonBody["username"];
      String password = jsonBody["password"];
      var connection = await MariadbDbConfiguration().connection;

      var query = await connection.query(
          "SELECT username, email FROM organiza_usuarios s WHERE username = '$username' AND email = '$email' ");

      if (query.isEmpty) {
        //add user
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
