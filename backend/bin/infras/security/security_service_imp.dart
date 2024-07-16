import "package:shelf/shelf.dart";
import "package:shelf/src/middleware.dart";
import "./validate/api_router_validate.dart";
import "security_service.dart";
import "package:dart_jsonwebtoken/dart_jsonwebtoken.dart";
import "../../utils/env_custom.dart";

class SecurityServiceImp implements SecurityService<JWT> {
  @override
  Future<String> generateJWT(String userdId) async {
    var jwt = JWT({
      "iat": DateTime.now().millisecondsSinceEpoch,
      "userId": userdId,
      "roles": ["admin", "user"]
    });
    String key = await EnvCustom.get(key: "jwt_key");
    String token = jwt.sign(SecretKey(key));
    return token;
  }

  @override
  Future<JWT?> validateJWT(String token) async {
    String key = await EnvCustom.get(key: "jwt_key");
    try {
      return JWT.verify(token, SecretKey(key));
    } on JWTInvalidException {
      return null;
    } on JWTNotActiveException {
      return null;
    } on JWTUndefinedException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Middleware get addJWTAuthorization {
    return (Handler handler) {
      return (Request req) async {
        String? authorizationHeader = req.headers["Authorization"];

        JWT? jwt;

        if (authorizationHeader != null) {
          if (authorizationHeader.startsWith("Bearer ")) {
            String token = authorizationHeader.substring(7);
            jwt = await validateJWT(token);
          }
        }
        var request = req.change(context: {"jwt": jwt});

        return handler(request);
      };
    };
  }

  @override
  Middleware get verifyJWT => createMiddleware(requestHandler: (Request req) {
        var _apiSecurity = ApiRouterValidate()
            .add("login")
            .add("blog")
            .add("signup")
            .add("login/test");

        if (_apiSecurity.isPublic(req.url.path)) return null;

        if (req.context["jwt"] == null) {
          return Response.forbidden("Not Authorizized");
        }
        return null;
      });
}
