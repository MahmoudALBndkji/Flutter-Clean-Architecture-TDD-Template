import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/models/task_model.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/failure.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/repos/task_repository_impl.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_remote_data_source.dart';

class MockRemoteDataSource extends Mock implements TaskRemoteDataSource {}

void main() {
  late TaskRemoteDataSource taskRemoteDataSource;
  late TaskRepository taskRepoImp;
  const title = '';
  const tag = '';
  final createdAt = DateTime.now();

  setUp(() {
    taskRemoteDataSource = MockRemoteDataSource();
    taskRepoImp = TaskRepositoryImpl(taskRemoteDataSource);
  });
  group(
    'create task',
    () {
      test(
        'should call [TaskRemoteDataSource.createTask] and return [Right<void>] when call is successfull',
        () async {
          // Arrange
          when(
            () => taskRemoteDataSource.createTask(
              title: any(named: 'title'),
              tag: any(named: 'tag'),
              createdAt: any(named: 'createdAt'),
            ),
          ).thenAnswer((_) async => Right(null));

          // Act
          final result = await taskRepoImp.createTask(
            title: title,
            tag: tag,
            createdAt: createdAt,
          );

          // Assert
          expect(result, Right<Failure, void>(null));
          verify(
            () => taskRemoteDataSource.createTask(
              title: title,
              tag: tag,
              createdAt: createdAt,
            ),
          ).called(1);
          verifyNoMoreInteractions(taskRemoteDataSource);
        },
      );

      test(
        'should call [RemoteDataSource.createTask] and return [Left<APIFailure, void>] when call is unsuccessfull',
        () async {
          // Arrange
          when(
            () => taskRemoteDataSource.createTask(
                title: any(named: 'title'),
                tag: any(named: 'tag'),
                createdAt: any(named: 'createdAt')),
          ).thenThrow(
            APIException(errorMessage: 'testErrorMessage', statusCode: 505),
          );

          // Act
          final result = await taskRepoImp.createTask(
            title: title,
            tag: tag,
            createdAt: createdAt,
          );

          // Assert
          expect(
            result,
            Left(
              APIFailure(messsage: 'testErrorMessage', statusCode: 505),
            ),
          );
          verify(
            () => taskRemoteDataSource.createTask(
              title: title,
              tag: tag,
              createdAt: createdAt,
            ),
          ).called(1);
          verifyNoMoreInteractions(taskRemoteDataSource);
        },
      );
    },
  );

  group('get all tasks', () {
    List<TaskModel> testingTasks = [
      TaskModel(
        id: 1,
        title: 'title',
        tag: 'tag',
        createdAt: DateTime(2025, 07, 16),
      ),
    ];
    test(
        'should call [RemoteDataSource.getAllTasks] and return [Right<List<TaskEntity>>] when call is successfull',
        () async {
      // Arrange
      when(() => taskRemoteDataSource.getAllTasks())
          .thenAnswer((_) async => Future.value(testingTasks));

      // Act
      final result = await taskRepoImp.getAllTasks();

      // Assert
      expect(result, Right<Failure, List<TaskEntity>>(testingTasks));
      verify(() => taskRemoteDataSource.getAllTasks()).called(1);
      verifyNoMoreInteractions(taskRemoteDataSource);
    });

    test(
        'should call [RemoteDataSouce.getAllTasks] and return [Left<APIFailure, List<TaskEntity>>] when call is unsuccessfull',
        () async {
      // Arrange
      when(() => taskRemoteDataSource.getAllTasks()).thenThrow(
        APIException(errorMessage: 'testErrorMessage', statusCode: 505),
      );

      // Act
      final result = await taskRepoImp.getAllTasks();

      // Assert
      expect(
        result,
        Left(
          APIFailure(messsage: 'testErrorMessage', statusCode: 505),
        ),
      );
      verify(() => taskRemoteDataSource.getAllTasks()).called(1);
      verifyNoMoreInteractions(taskRemoteDataSource);
    });
  });
}
