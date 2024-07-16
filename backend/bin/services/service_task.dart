import '../models/model_task.dart';
import './service_generic.dart';
import '../dao/dao_task.dart';

class ServiceTask implements ServiceGeneric<ModelTask> {
  final DaoTask taskDao;
  ServiceTask(this.taskDao);

  @override
  Future<bool> delete(int id) async {
    return true;
  }

  @override
  Future<List<ModelTask>> readAll() async {
    return await taskDao.readAll();
  }

  @override
  Future<ModelTask?> readOne(dynamic value) async {
    print("entered service task");
    return await taskDao.readOne(value);
  }

  @override
  Future<bool> update(ModelTask value) async {
    return true;
  }

  @override
  Future<bool> create(value) async {
    taskDao.create(value);
    return true;
  }
}
