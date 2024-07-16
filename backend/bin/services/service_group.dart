import '../models/model_group.dart';
import './service_generic.dart';
import '../dao/dao_group.dart';

class ServiceGroup implements ServiceGeneric<ModelGroup> {
  final DaoGroup groupDao;
  ServiceGroup(this.groupDao);

  @override
  Future<bool> delete(int id) async {
    return true;
  }

  @override
  Future<List<ModelGroup>> readAll() async {
    return await groupDao.readAll();
  }

  @override
  Future<ModelGroup?> readOne(dynamic value) async {
    print("entered service group");
    return await groupDao.readOne(value);
  }

  @override
  Future<bool> update(ModelGroup value) async {
    return true;
  }

  @override
  Future<bool> create(value) async {
    groupDao.create(value);
    return true;
  }
}
