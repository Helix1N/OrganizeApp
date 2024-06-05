import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class BlogAPI {
  Handler get handler {
    Router router = Router();

    router.get('/blog/noticias', (Request request) {
      return Response.ok('Essas são as noticias!');
    });
    return router;
  }
}
