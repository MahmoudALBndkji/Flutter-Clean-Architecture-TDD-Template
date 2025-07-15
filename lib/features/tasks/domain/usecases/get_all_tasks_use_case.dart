import 'package:flutter_clean_architecture_tdd_template/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_tdd_template/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';

class GetAllTasksUseCase implements Usecase<List<TaskEntity>> {
  final TaskRepository _taskRepo;
  GetAllTasksUseCase(this._taskRepo);

  @override
  FutureResult<List<TaskEntity>> call() async => await _taskRepo.getAllTasks();
}
