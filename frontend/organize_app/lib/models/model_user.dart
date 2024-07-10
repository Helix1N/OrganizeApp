class ModelUser {
  final int id;
  final String username;
  final String password;
  final String location;
  final String email;
  final bool isActive;

  ModelUser(this.id, this.username, this.location, this.email, this.isActive,
      this.password);
}
