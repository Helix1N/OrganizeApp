import 'package:shelf/shelf.dart';

class MiddlewareInterception {
  Middleware get addContentTypeJson => createMiddleware(
      responseHandler: (Response res) =>
          res.change(headers: {'content-type': 'application/json'}));
}
