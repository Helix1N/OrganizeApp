abstract class DbConfiguration {
  Future<dynamic> createConnection();
  dynamic get connection;
}
