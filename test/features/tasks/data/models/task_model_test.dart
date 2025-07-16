import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/models/task_model.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/domain/entities/task_entity.dart';

void main() {
  final testingModel = TaskModel(
    id: 0,
    title: 'title',
    tag: 'tag',
    createdAt: DateTime(2025, 07, 16),
  );

  final String testingJson = fixture('task.json')
      .replaceAll('\n', '')
      .replaceAll('\r', '')
      .replaceAll(' ', '');

  final testingMap = jsonDecode(testingJson);

  test('should implement [TaskEntity]', () {
    expect(testingModel, isA<TaskEntity>());
  });

  group("fromMap", () {
    test(
      'should return [TaskModel] when data is correct data',
      () {
        // Act
        final result = TaskModel.fromMap(testingMap);

        // Assert
        expect(result, testingModel);
      },
    );
  });
  group("toMap", () {
    test(
      'should return [DataMap] when data is correct data',
      () {
        // Act
        final result = testingModel.toMap();
        // Assert
        expect(result, testingMap);
      },
    );
  });

  group('toJson', () {
    test('should return [JSON string] when data is correct', () {
      // Act
      final result = testingModel.toJson();
      // Assert
      expect(result, testingJson);
    });
  });

  group('fromJson', () {
    test('should return [Task Model] when data is correct', () {
      // Act
      final result = TaskModel.fromJson(testingJson);
      // Assert
      expect(result, testingModel);
    });
  });

  group('copyWith', () {
    test('should return [New Task Model] when data is correct', () {
      // Act
      final result = testingModel.copyWith(title: 'newTitle');
      // Assert
      expect(result.title, 'newTitle');
      expect(result.tag, testingModel.tag);
      expect(result.id, testingModel.id);
      expect(result.createdAt, testingModel.createdAt);
    });
  });
}
