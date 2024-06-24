import '../models/model_news.dart';
import './service_generic.dart';

class ServiceNews implements ServiceGeneric<ModelNews> {
  List<ModelNews> _fakeDB = [];

  @override
  bool delete(int id) {
    _fakeDB.removeWhere((e) => e.id == id);
    return true;
  }

  @override
  List<ModelNews> findAll() {
    return _fakeDB;
  }

  @override
  ModelNews findOne(int id) {
    return _fakeDB.firstWhere((e) => e.id == id);
  }

  @override
  bool save(ModelNews value) {
    int index = _fakeDB.indexOf(value);
    if (index == -1) {
      _fakeDB.add(value);
    } else {
      _fakeDB[index] = value;
    }
    return true;
  }
}
