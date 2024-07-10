import 'model_task.dart';
import 'model_user.dart';

class ModelGroup {
  final String id;
  final String groupName;
  final List<ModelTask>? taskList;
  final List<ModelUser> usersList;

  ModelGroup(
      {required this.id,
      required this.groupName,
      this.taskList,
      required this.usersList});
}
