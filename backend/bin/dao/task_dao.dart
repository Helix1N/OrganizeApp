import './dao.dart';
import '../infras/database/db_configuration.dart';
import '../models/model_task.dart';

class TaskDao implements DAO<ModelTask> {
  final DbConfiguration _dbConfiguration;
  TaskDao(this._dbConfiguration);
  final _table_tasks = "organiza_tarefas";

  @override
  Future create(ModelTask value) async {
    var connection = await _dbConfiguration.connection;
    Map<String, dynamic> jsonModelTask = value.toJson();
    var result = await connection.query(
      'INSERT INTO $_table_tasks (id, title, subtitle, description, assignee_id, user_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        jsonModelTask['id'],
        jsonModelTask['title'],
        jsonModelTask['subtitle'],
        jsonModelTask['description'],
        jsonModelTask['assigneeId'],
        jsonModelTask['userId'],
        jsonModelTask['status']
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
    var connection = await _dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM $_table_tasks s");
    List<ModelTask> listTasks = [];
    for (var user in results) {
      listTasks.add(ModelTask.fromJson(user));
    }
    return listTasks;
  }

  @override
  Future<ModelTask?> readOne(int id) async {
    String query = "SELECT * FROM $_table_tasks s WHERE id = '$id'";
    var connection = await _dbConfiguration.connection;
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

  Future<ModelTask?> readOneTaskname(String username) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query(
        "SELECT * FROM organiza_usuarios s WHERE username = '$username'");
    ModelTask? user;
    for (var result in results) {
      user = ModelTask.fromMap(result.fields);
    }
    return user;
  }

  Future<ModelTask?> readOneLogin(String username, String password) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query(
        "SELECT * FROM organiza_usuarios s WHERE username = '$username' AND password = '$password'");
    ModelTask? user;
    for (var result in results) {
      user = ModelTask.fromMap(result.fields);
    }
    return user;
  }
}
