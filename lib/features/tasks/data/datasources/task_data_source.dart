import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/models/task_model.dart';

abstract class TaskDataSource {
  Future<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  });

  Future<List<TaskModel>> getAllTasks();
}
