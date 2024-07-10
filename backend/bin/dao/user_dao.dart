import '../models/model_user.dart';
import './dao.dart';
import '../infras/database/db_configuration.dart';

class UserDao implements DAO<ModelUser> {
  final DbConfiguration _dbConfiguration;
  UserDao(this._dbConfiguration);
  final String _tableUsers = "organiza_usuarios";

  @override
  Future create(ModelUser value) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM $_tableUsers s");
    return true;
  }

  @override
  Future delete(int id) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ModelUser>> readAll() async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query("SELECT * FROM $_tableUsers s");
    List<ModelUser> listUsers = [];
    for (var user in results) {
      listUsers.add(ModelUser.fromJson(user));
    }
    return listUsers;
  }

  @override
  Future<ModelUser?> readOne(int id) async {
    String query = "SELECT * FROM $_tableUsers s WHERE id = '$id'";
    var connection = await _dbConfiguration.connection;
    var results = await connection.query(query);
    ModelUser? user;
    for (var result in results) {
      user = ModelUser.fromMap(result.fields);
    }
    return user;
  }

  @override
  Future update(ModelUser value) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<ModelUser?> readOneUsername(String username) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection
        .query("SELECT * FROM $_tableUsers s WHERE username = '$username'");
    ModelUser? user;
    for (var result in results) {
      user = ModelUser.fromMap(result.fields);
    }
    return user;
  }

  Future<ModelUser?> readOneLogin(String username, String password) async {
    var connection = await _dbConfiguration.connection;
    var results = await connection.query(
        "SELECT * FROM $_tableUsers s WHERE username = '$username' AND password = '$password'");
    ModelUser? user;
    for (var result in results) {
      user = ModelUser.fromMap(result.fields);
    }
    return user;
  }
}
