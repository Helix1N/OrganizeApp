import 'dart:convert';

class ModelUser {
  final int id;
  final String name;
  final String password;
  final String location;
  final String email;
  final bool isActive;

  ModelUser({
    required this.id,
    required this.name,
    required this.password,
    required this.location,
    required this.email,
    required this.isActive,
  });

  factory ModelUser.fromMap(Map<String, dynamic> map) {
    bool isActive;
    if (map['is_active'] == null) {
      isActive = false;
    } else {
      isActive = map['is_active'] == 1;
    }
    return ModelUser(
      id: map['id'] ?? -1,
      name: map['name'] ?? "",
      location: map['location'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      isActive: isActive,
    );
  }
  factory ModelUser.fromJson(String source) {
    return ModelUser.fromMap(json.decode(source));
  }

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'location': location,
      'email': email,
      'is_active': isActive,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelUser &&
        other.id == id &&
        other.name == name &&
        other.password == password &&
        other.location == location &&
        other.email == email &&
        other.isActive == isActive;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      password.hashCode ^
      location.hashCode ^
      email.hashCode ^
      isActive.hashCode;

  @override
  String toString() {
    return 'ModelUser(id: $id, name: $name, password: $password, location: $location, email: $email, isActive: $isActive)';
  }
}
