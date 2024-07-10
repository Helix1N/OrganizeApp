import 'dart:convert';

class ModelStory {
  final int id;
  final int taskId;
  final String description;
  final int status;

  ModelStory(
      {required this.id,
      required this.taskId,
      required this.description,
      required this.status});

  factory ModelStory.fromMap(Map<String, dynamic> map) {
    return ModelStory(
      id: map['id'] ?? -1,
      taskId: map['taskId'],
      description: map['description'] ?? "",
      status: map['status'] ?? -1,
    );
  }
  factory ModelStory.fromJson(String source) {
    return ModelStory.fromMap(json.decode(source));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskId': taskId,
      'description': description,
      'status': status,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelStory &&
        other.id == id &&
        other.taskId == taskId &&
        other.description == description &&
        other.status == status;
  }

  @override
  int get hashCode =>
      id.hashCode ^ taskId.hashCode ^ description.hashCode ^ status.hashCode;

  @override
  String toString() {
    return 'ModelStory(id: $id, taskId: $taskId, description: $description, status: $status )';
  }
}
