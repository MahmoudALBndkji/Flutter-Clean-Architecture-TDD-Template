part of 'task_cubit.dart';

sealed class TaskState {
  const TaskState();
}

final class TaskInitial extends TaskState {
  const TaskInitial();
}

final class GettingTasks extends TaskState {
  const GettingTasks();
}

final class TasksLoaded extends TaskState {
  const TasksLoaded(this.tasks);
  final List<TaskEntity> tasks; 
}

final class TasksError extends TaskState {
  const TasksError(this.message);
  final String message;
}

final class CreatingTask extends TaskState {
  const CreatingTask();
}

final class TaskCreated extends TaskState {
  const TaskCreated();
}
