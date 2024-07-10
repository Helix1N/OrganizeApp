import 'dart:convert';
import './model_task.dart';
import './model_user.dart';

class ModelGroup {
  final int id;
  final String groupName;
  final List<ModelTask> taskList;
  final List<ModelUser> userList;

  ModelGroup({
    required this.userList,
    required this.id,
    required this.taskList,
    required this.groupName,
  });

  factory ModelGroup.fromMap(Map<String, dynamic> map) {
    return ModelGroup(
        id: map['id'] ?? -1,
        taskList: map['taskList'],
        groupName: map['groupName'] ?? "",
        userList: map['userList']);
  }
  factory ModelGroup.fromJson(String source) {
    return ModelGroup.fromMap(json.decode(source));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskList': taskList,
      'groupName': groupName,
      'userList': userList,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ModelGroup &&
        other.id == id &&
        other.taskList == taskList &&
        other.groupName == groupName &&
        other.userList == userList;
  }

  @override
  int get hashCode =>
      id.hashCode ^ taskList.hashCode ^ groupName.hashCode ^ userList.hashCode;

  @override
  String toString() {
    return 'ModelGroup(id: $id, taskList: $taskList, groupName: $groupName, userList: $userList)';
  }
}
