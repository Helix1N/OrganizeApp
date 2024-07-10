import "package:shelf/shelf.dart";
import "package:shelf_router/shelf_router.dart";
import "dart:convert" as json;
import "../infras/database/mariadb_db_configuration.dart";
import "../infras/security/security_service.dart";
import "./api.dart";
import "../models/model_user.dart";
import "../services/service_generic.dart";

class APISignUp extends API {
  final SecurityService _securityService;
  final ServiceGeneric<ModelUser> _userService;
  APISignUp(this._securityService, this._userService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false}) {
    Router router = Router();

    router.post("/signup", ((Request request) async {
      String body = await request.readAsString();
      Map<String, dynamic> jsonBody = json.jsonDecode(body);
      String email = jsonBody["email"];
      String username = jsonBody["username"];
      String password = jsonBody["password"];
      var connection = await MariadbDbConfiguration().connection;

      var query = await connection.query(
          "SELECT username FROM organiza_usuarios s WHERE username = '$username'");
      if (query.isNotEmpty) {
        return Response.unauthorized("Username already taken");
      }
      query = await connection.query(
          "SELECT email FROM organiza_usuarios s WHERE email = '$email'");
      if (query.isNotEmpty) {
        return Response.unauthorized("Email already taken");
      }

      var token = await _securityService.generateJWT("1");
      var result = await _securityService.validateJWT(token);

      connection.close();
      return Response.ok("{'key':'$token'}");
    }));

    router.get("/signup", ((Request request) {
      return Response.ok("OK");
    }));

    return createHandler(
        router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
