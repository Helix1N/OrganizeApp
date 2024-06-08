import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/service_generic.dart';

class APIBlog {
  final ServiceGeneric _service;
  APIBlog(this._service);

  Handler get handler {
    Router router = Router();

    router.get('/blog/news', (Request req) {
      _service.findAll();
      return Response.ok('Essas são as noticias!');
    });

    router.post('/blog/news', (Request req) async {
      String reqBody = await req.readAsString();

      _service.save('');

      return Response.ok(reqBody);
    });

    router.put('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      //_servico.save(id);
      return Response.ok('Choveu hoje');
    });

    router.delete('/blog/news', (Request req) {
      String? id = req.url.queryParameters['id'];
      return Response.ok('Choveu hoje');
    });

    return router;
  }
}
