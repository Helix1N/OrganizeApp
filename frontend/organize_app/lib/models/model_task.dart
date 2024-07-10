import 'package:organiza_app/models/model_story.dart';

class ModelTask {
  final int id;
  final String title;
  final String subtitle;
  final String description;
  final int assigneeId;
  final int userId;
  final int status;
  final List<ModelStory>? stories;

  ModelTask(
      {required this.id,
      required this.status,
      required this.assigneeId,
      required this.userId,
      required this.title,
      required this.subtitle,
      required this.description,
      this.stories});
}
