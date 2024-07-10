import "dart:convert" as json;
import "package:shelf/shelf.dart";
import "package:shelf_router/shelf_router.dart";
import "./api.dart";
import "../infras/security/security_service.dart";
import "../services/service_task.dart";
import "../models/model_task.dart";

class APITask extends API {
  final SecurityService _securityService;
  final ServiceTask _taskService;
  APITask(this._securityService, this._taskService);

  @override
  Handler getHandler({List<Middleware>? middlewares, bool isSecurity = true}) {
    Router router = Router();

    router.post('/task', ((Request request) async {
      String body = await request.readAsString();
      Map<String, dynamic> jsonBody = json.jsonDecode(body);
      ModelTask task = ModelTask.fromMap(jsonBody);
      print(task);
      bool result = await _taskService.create(task);
      if (result) {
        return Response.ok("Task Created");
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
