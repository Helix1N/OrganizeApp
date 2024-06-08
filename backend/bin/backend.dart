import 'package:shelf/shelf.dart';
import './infras/server_custom.dart';
import './apis/api_login.dart';
import './apis/api_blog.dart';
import './utils/env_custom.dart';
import './services/service_news.dart';
import './infras/database/mariadb_db_configuration.dart';

void main() async {
  var connection = await MariadbDbConfiguration().connection;

  var results = await connection.query("SELECT * FROM organiza_usuarios s");
  print(results);

  var cascadeHandler = Cascade()
      .add(APILogin().handler)
      .add(APIBlog(ServiceNews()).handler)
      .handler;

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await ServidorCustom().initialize(
      handler: handler,
      address: await EnvCustom.get<String>(key: 'server_address'),
      port: await EnvCustom.get<int>(key: 'server_port'));
}
