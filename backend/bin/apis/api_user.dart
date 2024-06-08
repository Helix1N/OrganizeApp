import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class APIUser {
  Handler get handler {
    Router router = Router();

    router.post('/user/save', (Request request) {
      return Response.ok('API de User');
    });

    return router;
  }
}
