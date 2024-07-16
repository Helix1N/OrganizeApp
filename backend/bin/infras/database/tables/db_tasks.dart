class DBTasks {
  final String table;
  final String id;
  final String title;
  final String description;
  final String subtitle;
  final String idAssignee;
  final String idUser;
  final String status;
  DBTasks(
      {required this.subtitle,
      required this.title,
      required this.table,
      required this.status,
      required this.idAssignee,
      required this.id,
      required this.idUser,
      required this.description});
}
