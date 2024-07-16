import 'model_task.dart';
import 'model_user.dart';

class ModelGroup {
  final String id;
  final String name;
  final List<ModelTask>? taskList;
  final List<ModelUser> usersList;

  ModelGroup(
      {required this.id,
      required this.name,
      this.taskList,
      required this.usersList});
}
