class ModelUser {
  final String name;
  final int id;
  final String location;
  final String email;

  ModelUser(this.id, this.name, this.location, this.email);

  factory ModelUser.fromJson(Map json) {
    return ModelUser(json['id'], json['name'], json['location'], json['email']);
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'email': email,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelUser &&
        other.id == id &&
        other.name == name &&
        other.location == location &&
        other.email == email;
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ location.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'ModelUser(id: $id, name: $name, location: $location, email: $email)';
  }
}
