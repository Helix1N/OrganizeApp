import './dao.dart';
import '../infras/database/db_configuration.dart';
import '../models/model_group.dart';

class DaoGroup implements DAO<ModelGroup> {
  final DBConfiguration _dbConfiguration;
  DaoGroup(this._dbConfiguration);
  final _table_groups = "organiza_grupos";

  @override
  Future create(ModelGroup value) async {
    var connection = await _dbConfiguration.connection;
    Map<String, dynamic> jsonModelGroup = value.toJson();
    var result = await connection.query(
      'INSERT INTO $_table_groups (id, title, subtitle, description, assignee_id, user_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [
        jsonModelGroup['id'],
        jsonModelGroup['title'],
        jsonModelGroup['subtitle'],
        jsonModelGroup['description'],
        jsonModelGroup['assigneeId'],
        jsonModelGroup['userId'],
        jsonModelGroup['status']
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
  Future<List<ModelGroup>> readAll() async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM $_table_groups s");
    List<ModelGroup> listGroups = [];
    for (var user in results) {
      listGroups.add(ModelGroup.fromJson(user));
    }
    return listGroups;
  }

  @override
  Future<ModelGroup?> readOne(int id) async {
    String query = "SELECT * FROM $_table_groups s WHERE id = '$id'";
    var connection = await _dbConfiguration.connection;
    var results = await connection.query(query);
    ModelGroup? user;
    for (var result in results) {
      user = ModelGroup.fromMap(result.fields);
    }
    return user;
  }

  @override
  Future update(ModelGroup value) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<ModelGroup?> readOneGroupname(String name) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection
        .query("SELECT * FROM organiza_usuarios s WHERE name = '$name'");
    ModelGroup? user;
    for (var result in results) {
      user = ModelGroup.fromMap(result.fields);
    }
    return user;
  }

  Future<ModelGroup?> readOneLogin(String name, String password) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query(
        "SELECT * FROM organiza_usuarios s WHERE name = '$name' AND password = '$password'");
    ModelGroup? user;
    for (var result in results) {
      user = ModelGroup.fromMap(result.fields);
    }
    return user;
  }
}
