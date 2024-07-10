import '../models/model_user.dart';
import './service_generic.dart';
import '../dao/user_dao.dart';

class ServiceLogin implements ServiceGeneric<ModelUser> {
  final UserDao userDao;
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
    return true;
  }

  Future<ModelUser?> readOneUsername(String username) async {
    return await userDao.readOneUsername(username);
  }

  Future<ModelUser?> readOneLogin(String username, String password) async {
    return await userDao.readOneLogin(username, password);
  }

  @override
  Future<bool> create(ModelUser value) {
    // TODO: implement create
    throw UnimplementedError();
  }
}
