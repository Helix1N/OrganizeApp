import 'package:mysql1/mysql1.dart';
import './db_configuration.dart';
import '../../utils/env_custom.dart';

class MariadbDBConfiguration implements DBConfiguration {
  MySqlConnection? _connection;

  @override
  Future<MySqlConnection> get connection async {
    _connection ??= await createConnection();
    if (_connection == null) {
      throw Exception('[ERRO/DB] -> Failed Connection DB');
    }
    return _connection!;
  }

  @override
  Future createConnection() async {
    return await MySqlConnection.connect(ConnectionSettings(
        host: await EnvCustom.get(key: 'db_host'),
        port: await EnvCustom.get(key: 'db_port'),
        user: await EnvCustom.get(key: 'db_user'),
        password: await EnvCustom.get(key: 'db_pass'),
        db: await EnvCustom.get(key: 'db_schema')));
  }
}
