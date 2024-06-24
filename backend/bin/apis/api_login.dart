import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../infras/security/security_service.dart';
import './api.dart';

class APILogin extends API {
  final SecurityService _securityService;
  APILogin(this._securityService);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.post('/login', ((Request request) async {
      var token = await _securityService.generateJWT('1');
      var result = await _securityService.validateJWT(token);
      return Response.ok(token);
    }));

    return createHandler(router: router, middlewares: middlewares);
  }
}
