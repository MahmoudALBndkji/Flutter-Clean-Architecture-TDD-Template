import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/failure.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/params/create_task_params.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/presentation/cubits/task/task_cubit.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/create_task_use_case.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/usecases/get_all_tasks_use_case.dart';

class MockGetAllTasks extends Mock implements GetAllTasksUseCase {}

class MockCreateTask extends Mock implements CreateTaskUseCase {}

void main() {
  late GetAllTasksUseCase getAllTasksUseCase;
  late CreateTaskUseCase createTaskUseCase;
  late TaskCubit taskCubit;
  final testingCreateTaskParams = CreateTaskParams(
    title: 'title',
    tag: 'tag',
    createdAt: DateTime(2025, 07, 17),
  );
  final testingTaskList = [TaskEntity.test()];
  setUp(() {
    getAllTasksUseCase = MockGetAllTasks();
    createTaskUseCase = MockCreateTask();
    taskCubit = TaskCubit(
      getAllTasksUseCase: getAllTasksUseCase,
      createTaskUseCase: createTaskUseCase,
    );
    registerFallbackValue(testingCreateTaskParams);
  });

  tearDown(() {
    taskCubit.close();
  });

  test('every cubit should start with [TaskInitial]', () {
    expect(taskCubit.state, isA<TaskInitial>());
  });
  group(
    'create task',
    () {
      blocTest<TaskCubit, TaskState>(
        'should emit [CreatingTask , TaskCreated] when successful',
        build: () {
          // Arrange
          when(
            () => createTaskUseCase(any()),
          ).thenAnswer(
            (_) async => const Right(null),
          );
          return taskCubit;
        },
        act: (taskCubit) {
          // Act
          return taskCubit.createTask(
            title: testingCreateTaskParams.title,
            tag: testingCreateTaskParams.tag,
            createdAt: testingCreateTaskParams.createdAt,
          );
        },
        expect: () {
          // Assert
          return const [
            CreatingTask(),
            TaskCreated(),
          ];
        },
        verify: (taskCubit) {
          verify(
            () => createTaskUseCase(testingCreateTaskParams),
          ).called(1);
          verifyNoMoreInteractions(createTaskUseCase);
        },
      );

      blocTest<TaskCubit, TaskState>(
        'should emit [CreatingTask , TaskError] when failed',
        build: () {
          // Arrange
          when(
            () => createTaskUseCase(any()),
          ).thenAnswer(
            (_) async => Left(
              APIFailure(
                messsage: 'error',
                statusCode: 500,
              ),
            ),
          );
          return taskCubit;
        },
        act: (taskCubit) {
          // Act
          return taskCubit.createTask(
            title: testingCreateTaskParams.title,
            tag: testingCreateTaskParams.tag,
            createdAt: testingCreateTaskParams.createdAt,
          );
        },
        expect: () {
          // Assert
          return const [
            CreatingTask(),
            TasksError('error'),
          ];
        },
        verify: (taskCubit) {
          verify(
            () => createTaskUseCase(testingCreateTaskParams),
          ).called(1);
          verifyNoMoreInteractions(createTaskUseCase);
        },
      );
    },
  );

  group('getting all tasks', () {
    blocTest<TaskCubit, TaskState>(
      'should emit [GettingTasks, TasksLoaded] when successful',
      build: () {
        // Arrange
        when(() => getAllTasksUseCase())
            .thenAnswer((_) async => Right(testingTaskList));
        return taskCubit;
      },
      act: (cubit) {
        // Act
        return cubit.getAllTaks();
      },
      expect: () {
        // Assert
        return [
          GettingTasks(),
          TasksLoaded(testingTaskList),
        ];
      },
      verify: (cubit) {
        verify(() => getAllTasksUseCase()).called(1);
        verifyNoMoreInteractions(getAllTasksUseCase);
      },
    );

    blocTest<TaskCubit, TaskState>(
      'should emit [GettingTasks, TasksError] when successful',
      build: () {
        // Arrange
        when(() => getAllTasksUseCase()).thenAnswer(
          (_) async => Left(
            APIFailure(messsage: 'error', statusCode: 505),
          ),
        );
        return taskCubit;
      },
      act: (cubit) {
        // Act
        return cubit.getAllTaks();
      },
      expect: () {
        // Assert
        return const [
          GettingTasks(),
          TasksError('error'),
        ];
      },
      verify: (cubit) {
        verify(() => getAllTasksUseCase()).called(1);
        verifyNoMoreInteractions(getAllTasksUseCase);
      },
    );
  });
}
