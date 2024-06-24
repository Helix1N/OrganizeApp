import 'package:shelf/shelf.dart';

abstract class API {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler(
      {required Handler router, required List<Middleware>? middlewares}) {
    var pipeline = Pipeline();

    middlewares ??= [];
    middlewares.forEach((m) => pipeline = pipeline.addMiddleware(m));
    return pipeline.addHandler(router);
  }
}
