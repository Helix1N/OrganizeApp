import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../services/service_generic.dart';
import '../models/model_news.dart';
import './api.dart';
import 'dart:convert';

class APIBlog extends API {
  final ServiceGeneric<ModelNews> _service;
  APIBlog(this._service);

  @override
  Handler getHandler({List<Middleware>? middlewares}) {
    Router router = Router();

    router.get('/blog/news', (Request req) {
      List<ModelNews> listNews = _service.findAll();
      List<Map> mapNews = listNews.map((e) => e.toJson()).toList();
      return Response.ok(jsonEncode(mapNews));
    });

    router.post('/blog/news', (Request req) async {
      String reqBody = await req.readAsString();
      _service.save(ModelNews.fromJson(json.decode(reqBody)));
      return Response(201);
    });

    router.put('/blog/news', (Request req) async {});

    router.delete('/blog/news', (Request req) {});

    return createHandler(router: router, middlewares: middlewares);
  }
}
