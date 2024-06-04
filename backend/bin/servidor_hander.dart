import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class ServidorHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    return router;
  }
}
