class ModelUser {
  final String name;
  final int id;
  final String location;

  ModelUser(this.id, this.name, this.location);

  @override
  String toString() {
    return 'ModelUser(id: $id, name: $name, location: $location)';
  }
}
