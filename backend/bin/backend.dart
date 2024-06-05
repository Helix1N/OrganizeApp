import 'package:shelf/shelf.dart';
import './infra/servidor_custom.dart';
import './api/login_api.dart';
import './api/blog_api.dart';

void main() async {
  var cascadeHandler =
      Cascade().add(LoginAPI().handler).add(BlogAPI().handler).handler;

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await ServidorCustom().initialize(handler);
}
