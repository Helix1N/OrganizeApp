abstract class DBConfiguration {
  Future<dynamic> createConnection();
  dynamic get connection;
}
