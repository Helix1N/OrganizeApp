import 'dart:convert';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf/shelf.dart';

class ServidorHandler {
  Handler get handler {
    final router = Router();

    router.get('/', (Request request) {
      return Response(200, body: 'Primeira Rota');
    });

    router.get('/ola/mundo/<usuario>', (Request req, String usuario) {
      return Response.ok("Ola Mundo $usuario");
    });

    router.get('/query', (Request req) {
      String? nome = req.url.queryParameters['nome'];
      String? idade = req.url.queryParameters['idade'];
      return Response.ok("Query eh: $nome e $idade");
    });

    router.post('/login', (Request req) async {
      var result = await req.readAsString();

      Map json = jsonDecode(result);
      if (json['usuario'] == 'admin' && json['senha'] == '123') {
        return Response.ok("Bem vindo admin!");
      } else {
        return Response.forbidden("Acesso negado");
      }
    });

    return router;
  }
}
