import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/failure.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/get_all_tasks_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository repo;
  late GetAllTasksUseCase getAllTasks;

  setUp(() {
    repo = MockTaskRepository();
    getAllTasks = GetAllTasksUseCase(repo);
  });

  test(
    'should call [TaskRepository.getAllTasksUseCase] and return [Right<List<TaskEntity>>] when success',
    () async {
      // [AAA Steps]

      // 1- Arrange [Preparing Dependencies] //
      final testingTasks = [
        TaskEntity.test(),
      ];

      when(() => repo.getAllTasks())
          .thenAnswer((_) async => Right(testingTasks));

      // 2- Act [Get Result] //
      final result = await getAllTasks();

      // 3- Assert [Check Expected Equality Result]
      expect(result, equals(Right<Failure, List<TaskEntity>>(testingTasks)));
      verify(() => repo.getAllTasks()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
