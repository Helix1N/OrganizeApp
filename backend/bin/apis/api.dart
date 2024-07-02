import 'package:shelf/shelf.dart';
import '../infras/dependecy_injector/dependency_injector.dart';
import '../infras/security/security_service.dart';

abstract class API {
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = false});

  Handler createHandler(
      {required Handler router,
      required List<Middleware>? middlewares,
      bool isSecurity = false}) {
    var pipeline = Pipeline();

    middlewares ??= [];
    if (isSecurity) {
      var _securityService = DependencyInjector().get<SecurityService>();
      middlewares.addAll([
        _securityService.addJWTAuthorization,
        _securityService.verifyJWT,
      ]);
    }
    middlewares.forEach((m) => pipeline = pipeline.addMiddleware(m));
    return pipeline.addHandler(router);
  }
}
