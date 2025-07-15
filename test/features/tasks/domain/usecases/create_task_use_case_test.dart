import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/failure.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/params/create_task_params.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskRepository repo;
  late CreateTaskUseCase createTaskUseCase;

  setUp(() {
    repo = MockTaskRepository();
    createTaskUseCase = CreateTaskUseCase(repo);
  });

  test(
    'should call [TaskRepository.createTaskUseCase] and return [Right<void>] when success',
    () async {
      // Arrange
      final params = CreateTaskParams.test();

      when(
        () => repo.createTask(
          title: any(named: 'title'),
          tag: any(named: 'tag'),
          createdAt: any(named: 'createdAt'),
        ),
      ).thenAnswer(
        (_) async => Right<Failure, void>(null),
      );

      // Act
      final result = await createTaskUseCase(params);

      // Assert
      expect(result, equals(Right<Failure, void>(null)));
      verify(
        () => repo.createTask(
          title: params.title,
          tag: params.tag,
          createdAt: params.createdAt,
        ),
      ).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
