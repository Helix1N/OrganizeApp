class ModelUser {
  final int id;
  final String name;
  final String password;
  final String location;
  final String email;
  final bool isActive;

  ModelUser(this.id, this.name, this.location, this.email, this.isActive,
      this.password);
}
