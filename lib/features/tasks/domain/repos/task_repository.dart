import 'package:flutter_clean_architecture_tdd_template/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';

abstract class TaskRepository {
  FutureResult<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  });

  FutureResult<List<TaskEntity>> getAllTasks();
}
