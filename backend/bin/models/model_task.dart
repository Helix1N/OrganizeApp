import 'dart:convert';
import './model_story.dart';

class ModelTask {
  final int? id;
  final String title;
  final String subtitle;
  final String description;
  final int assigneeId;
  final int userId;
  final int status;
  final List<ModelStory>? stories;

  ModelTask(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.assigneeId,
      required this.status,
      required this.userId,
      this.stories});

  factory ModelTask.fromMap(Map<String, dynamic> map) {
    return ModelTask(
      id: map['id'],
      title: map['title'] ?? "",
      subtitle: map['subtitle'] ?? "",
      description: map['description'] ?? "",
      status: map['status'] ?? -1,
      assigneeId: map['assigneeId'] ?? -1,
      userId: map['userId'] ?? -1,
      stories: map['stories'],
    );
  }
  factory ModelTask.fromJson(String source) {
    return ModelTask.fromMap(json.decode(source));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'status': status,
      'assigneeId': assigneeId,
      'userId': userId,
      'stories': stories,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelTask &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.status == status &&
        other.assigneeId == assigneeId &&
        other.userId == userId &&
        other.stories == stories;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      description.hashCode ^
      status.hashCode ^
      assigneeId.hashCode ^
      userId.hashCode ^
      stories.hashCode;

  @override
  String toString() {
    return 'ModelTask(id: $id, title: $title, subtitle: $subtitle description: $description, status: $status, assigneeId: $assigneeId, userId: $userId, stories: $stories)';
  }
}
