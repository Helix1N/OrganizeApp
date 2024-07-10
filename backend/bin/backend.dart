import 'package:shelf/shelf.dart';
import './infras/server_custom.dart';
import './apis/api_login.dart';
import './apis/api_task.dart';
import './utils/env_custom.dart';
import './infras/database/db_configuration.dart';
import './infras/middleware_interception.dart';
import './infras/dependecy_injector/injects.dart';

void main() async {
  final _di = Injects.initialize();

  var connection = await _di.get<DbConfiguration>().connection;
  var results = await connection.query("SELECT * FROM organiza_usuarios s");
  print(results);

  var cascadeHandler = Cascade()
      .add(_di.get<APILogin>().getHandler())
      .add(_di.get<APITask>().getHandler())
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().addContentTypeJson)
      .addHandler(cascadeHandler);

  await ServidorCustom().initialize(
      handler: handler,
      address: await EnvCustom.get<String>(key: 'server_address'),
      port: await EnvCustom.get<int>(key: 'server_port'));
}
