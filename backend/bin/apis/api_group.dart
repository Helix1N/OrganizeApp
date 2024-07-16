import "dart:convert" as json;
import "package:shelf/shelf.dart";
import "package:shelf_router/shelf_router.dart";
import "./api.dart";
import "../infras/security/security_service.dart";
import "../services/service_group.dart";
import "../models/model_group.dart";

class APIGroup extends API {
  final SecurityService _securityService;
  final ServiceGroup _groupService;
  APIGroup(this._securityService, this._groupService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true}) {
    Router router = Router();

    router.post('/group/testing', ((Request request) async {
      return Response.movedPermanently("Hello");
    }));

    router.get('/group/Hello', ((Request request) async {
      return Response.ok("Hello");
    }));

    router.post('/group/create', ((Request request) async {
      String body = await request.readAsString();
      Map<String, dynamic> jsonBody = json.jsonDecode(body);
      ModelGroup group = ModelGroup.fromMap(jsonBody);
      print(group);
      return Response.ok("olo");
      bool result = await _groupService.create(group);
      if (result) {
        return Response.ok("Group Created");
      }

      var token = await _securityService.generateJWT('1');
      var resultValidate = await _securityService.validateJWT(token);
      return Response.notModified();
    }));

    router.get('/login', ((Request request) {
      return Response.ok("OK");
    }));

    return createHandler(
        router: router, middlewares: middlewares, isSecurity: isSecurity);
  }
}
