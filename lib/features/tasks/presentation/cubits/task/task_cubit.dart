import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/params/create_task_params.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/get_all_tasks_use_case.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetAllTasksUseCase _getAllTasksUseCase;
  final CreateTaskUseCase _createTaskUseCase;
  TaskCubit({
    required GetAllTasksUseCase getAllTasksUseCase,
    required CreateTaskUseCase createTaskUseCase,
  })  : _getAllTasksUseCase = getAllTasksUseCase,
        _createTaskUseCase = createTaskUseCase,
        super(TaskInitial());

  Future<void> getAllTaks() async {
    emit(const GettingTasks());
    final result = await _getAllTasksUseCase();
    result.fold(
      (failure) => emit(TasksError(failure.messsage)),
      (data) => emit(TasksLoaded(data)),
    );
  }

  Future<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  }) async {
    emit(const CreatingTask());
    final result = await _createTaskUseCase(
      CreateTaskParams(
        title: title,
        tag: tag,
        createdAt: createdAt,
      ),
    );
    result.fold(
      (failure) => emit(TasksError(failure.messsage)),
      (data) => emit(const TaskCreated()),
    );
  }
}
