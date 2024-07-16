class DBUsers {
  final String table;
  final String id;
  final String name;
  final String location;
  final String password;
  final String email;
  final String isActive;
  DBUsers(
      {required this.location,
      required this.password,
      required this.table,
      required this.email,
      required this.isActive,
      required this.id,
      required this.name});
}
