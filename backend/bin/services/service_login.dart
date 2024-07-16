import '../models/model_user.dart';
import './service_generic.dart';
import '../dao/dao_user.dart';

class ServiceLogin implements ServiceGeneric<ModelUser> {
  final DaoUser userDao;
  ServiceLogin(this.userDao);

  @override
  Future<bool> delete(int id) async {
    return true;
  }

  @override
  Future<List<ModelUser>> readAll() async {
    return await userDao.readAll();
  }

  @override
  Future<ModelUser?> readOne(int id) async {
    print("entered service user");
    return await userDao.readOne(id);
  }

  @override
  Future<bool> update(ModelUser value) async {
    userDao.update(value);
    return true;
  }

  Future<ModelUser?> readOneUsername(String name) async {
    return await userDao.readOneUsername(name);
  }

  Future<ModelUser?> readOneLogin(String name, String password) async {
    return await userDao.readOneLogin(name, password);
  }

  @override
  Future<bool> create(ModelUser value) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
