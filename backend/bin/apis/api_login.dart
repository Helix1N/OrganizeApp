import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class APILogin {
  Handler get handler {
    Router router = Router();

    router.post('/login', (Request request) {
      return Response.ok('API de Login');
    });

    return router;
  }
}
