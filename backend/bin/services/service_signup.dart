import '../models/model_user.dart';
import './service_generic.dart';
import '../dao/dao_user.dart';

class ServiceSignUp implements ServiceGeneric<ModelUser> {
  final DaoUser userDao;
  ServiceSignUp(this.userDao);

  @override
  Future<bool> delete(int id) async {
    return true;
  }

  @override
  Future<List<ModelUser>> readAll() async {
    return await userDao.readAll();
  }

  @override
  Future<ModelUser?> readOne(dynamic value) async {
    print("entered service user");
    return await userDao.readOne(value);
  }

  @override
  Future<bool> update(ModelUser value) async {
    return true;
  }

  @override
  Future create(ModelUser value) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
