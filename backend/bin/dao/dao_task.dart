import './dao.dart';
import '../infras/database/db_configuration.dart';
import '../models/model_task.dart';
import '../infras/database/tables/db_tasks.dart';

class DaoTask implements DAO<ModelTask> {
  final DBConfiguration dbConfiguration;
  final DBTasks dbTasks;
  DaoTask({required this.dbConfiguration, required this.dbTasks});

  @override
  Future create(ModelTask value) async {
    var connection = await dbConfiguration.connection;
    Map<String, dynamic> jsonModelTask = value.toJson();
    var result = await connection.query(
      'INSERT INTO ${dbTasks.table} (${dbTasks.id}, ${dbTasks.title}, ${dbTasks.subtitle}, ${dbTasks.description}, ${dbTasks.idAssignee}, ${dbTasks.idUser}, ${dbTasks.status}) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        jsonModelTask[dbTasks.id],
        jsonModelTask[dbTasks.title],
        jsonModelTask[dbTasks.subtitle],
        jsonModelTask[dbTasks.description],
        jsonModelTask[dbTasks.idAssignee],
        jsonModelTask[dbTasks.idUser],
        jsonModelTask[dbTasks.status]
      ],
    );
    print(result);
    return true;
  }

  @override
  Future delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ModelTask>> readAll() async {
    var connection = await dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM ${dbTasks.table} s");
    List<ModelTask> listTasks = [];
    for (var user in results) {
      listTasks.add(ModelTask.fromJson(user));
    }
    return listTasks;
  }

  @override
  Future<ModelTask?> readOne(int id) async {
    String query =
        "SELECT * FROM ${dbTasks.table} s WHERE ${dbTasks.id} = '$id'";
    var connection = await dbConfiguration.connection;
    var results = await connection.query(query);
    ModelTask? user;
    for (var result in results) {
      user = ModelTask.fromMap(result.fields);
    }
    return user;
  }

  @override
  Future update(ModelTask value) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
