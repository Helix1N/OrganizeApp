import '../models/model_user.dart';
import './service_generic.dart';

class ServiceUser implements ServiceGeneric<ModelUser> {
  @override
  bool delete(int value) {
    return true;
  }

  @override
  List<ModelUser> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  ModelUser findOne(int id) {
    // TODO: implement findOne
    throw UnimplementedError();
  }

  @override
  bool save(ModelUser value) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
