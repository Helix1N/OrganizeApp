import '../models/model_user.dart';
import './dao.dart';
import '../infras/database/db_configuration.dart';
import '../infras/database/tables/db_users.dart';

class DaoUser implements DAO<ModelUser> {
  final DBConfiguration dbConfiguration;
  final DBUsers dbUsers;
  DaoUser({required this.dbConfiguration, required this.dbUsers});

  @override
  Future create(ModelUser value) async {
    var connection = await dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM ${dbUsers.table} s");
    return true;
  }

  @override
  Future delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ModelUser>> readAll() async {
    var connection = await dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM ${dbUsers.table} s");
    List<ModelUser> listUsers = [];
    for (var user in results) {
      listUsers.add(ModelUser.fromJson(user));
    }
    return listUsers;
  }

  @override
  Future<ModelUser?> readOne(int id) async {
    String query =
        "SELECT * FROM ${dbUsers.table} s WHERE ${dbUsers.id} = '$id'";
    var connection = await dbConfiguration.connection;
    var results = await connection.query(query);
    ModelUser? user;
    for (var result in results) {
      user = ModelUser.fromMap(result.fields);
    }
    return user;
  }

  @override
  Future update(ModelUser value) async {
    print(dbUsers.table);
    return true;
  }

  Future<ModelUser?> readOneUsername(String name) async {
    var connection = await dbConfiguration.connection;
    var results = await connection.query(
        "SELECT * FROM ${dbUsers.table} s WHERE ${dbUsers.name} = '$name'");
    ModelUser? user;
    for (var result in results) {
      user = ModelUser.fromMap(result.fields);
    }
    return user;
  }

  Future<ModelUser?> readOneLogin(String name, String password) async {
    final String tableUsers = dbUsers.table;
    var connection = await dbConfiguration.connection;
    var results = await connection.query(
        "SELECT * FROM $tableUsers s WHERE name = '$name' AND ${dbUsers.password} = '$password'");
    ModelUser? user;
    for (var result in results) {
      user = ModelUser.fromMap(result.fields);
    }
    return user;
  }
}
