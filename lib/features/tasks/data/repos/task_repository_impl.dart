import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/failure.dart';
import 'package:flutter_clean_architecture_tdd_template/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_data_source.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/repos/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _datasource;
  const TaskRepositoryImpl(this._datasource);

  @override
  FutureResult<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  }) async {
    try {
      await _datasource.createTask(
        title: title,
        tag: tag,
        createdAt: createdAt,
      );
      return const Right(null);
    } on APIException catch (e) {
      return Left(
        APIFailure(messsage: e.errorMessage, statusCode: e.statusCode),
      );
    }
  }

  @override
  FutureResult<List<TaskEntity>> getAllTasks() async {
    try {
      final result = await _datasource.getAllTasks();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure(messsage: e.errorMessage, statusCode: e.statusCode),
      );
    }
  }
}
