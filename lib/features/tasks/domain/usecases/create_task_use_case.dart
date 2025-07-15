import 'package:flutter_clean_architecture_tdd_template/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_tdd_template/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/params/create_task_params.dart';

class CreateTaskUseCase implements UsecaseWithParams<void, CreateTaskParams> {
  final TaskRepository _taskRepo;
  CreateTaskUseCase(this._taskRepo);

  @override
  FutureResult<void> call(CreateTaskParams params) async =>
      await _taskRepo.createTask(
        title: params.title,
        tag: params.tag,
        createdAt: params.createdAt,
      );
}
