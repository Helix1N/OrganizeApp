import 'package:shelf/shelf.dart';
import './infras/server_custom.dart';
import './apis/api_login.dart';
import './apis/api_blog.dart';
import './utils/env_custom.dart';
import './services/service_news.dart';
import './infras/database/mariadb_db_configuration.dart';
import './infras/middleware_interception.dart';
import './infras/security/security_service_imp.dart';

void main() async {
  var connection = await MariadbDbConfiguration().connection;

  var results = await connection.query("SELECT * FROM organiza_usuarios s");
  print(results);
  connection.close();

  var _securityService = SecurityServiceImp();

  var cascadeHandler = Cascade()
      .add(APILogin(_securityService).getHandler())
      .add(APIBlog(ServiceNews()).getHandler())
      .handler;
  var handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(MiddlewareInterception().addContentTypeJson)
      .addMiddleware(_securityService.addJWTAuthorization)
      .addMiddleware(_securityService.verifyJWT)
      .addHandler(cascadeHandler);

  await ServidorCustom().initialize(
      handler: handler,
      address: await EnvCustom.get<String>(key: 'server_address'),
      port: await EnvCustom.get<int>(key: 'server_port'));
}
