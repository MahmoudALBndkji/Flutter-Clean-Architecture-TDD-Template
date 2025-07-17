import 'dart:convert';

import 'package:flutter_clean_architecture_tdd_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_template/core/utils/constants.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_data_source.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/models/task_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client httpClient;
  late TaskDataSource taskRemoteDataSource;
  setUp(() {
    httpClient = MockHttpClient();
    taskRemoteDataSource = TaskRemoteDataSource(httpClient);
    // any() : Generate Random Fake Data For Primitive Data Type Like (int , String , Bool) ,
    // but when use any in Uri and another non-Primitive Data Type Generated Fail
    // This Used When Fail Generate Random Fake Data From any()
    registerFallbackValue(Uri());
  });

  test('should implement [TaskDataSource]', () {
    expect(taskRemoteDataSource, isA<TaskDataSource>());
  });

  group(
    'create task',
    () {
      final body = jsonEncode({
        'tag': 'tag',
        "title": 'title',
        'createdAt': DateTime(2025, 07, 16).toIso8601String(),
      });
      test(
        'should call the server and return [void] when the call is successfull',
        () async {
          // Arrange
          when(
            () => httpClient.post(
              any(),
              body: any(named: 'body'),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer((_) async => http.Response('ok', 200));

          // ------------------ //
          // 1- First Way
          // // Act
          // final result = taskRemoteDataSource.createTask;
          // // Assert
          // expect(
          //   result(
          //     title: 'title',
          //     tag: 'tag',
          //     createdAt: DateTime(2025, 16, 07),
          //   ),
          //   completes,
          // );
          // ------------------ //
          // 2- Second Way [Better For Seperation Act & Assert]

          // Act
          final result = taskRemoteDataSource.createTask(
            title: 'title',
            tag: 'tag',
            createdAt: DateTime(2025, 07, 16),
          );

          // Assert
          expectLater(result, completes);
          // ------------------ //
          verify(
            () => httpClient.post(
              Uri.parse('$kBaseUrl/tasks'),
              body: body,
              headers: {
                "content-type": "application/json",
              },
            ),
          ).called(1);
          verifyNoMoreInteractions(httpClient);
        },
      );
      test(
        'should call server and return [APIException] when call is unseuccessfull',
        () async {
          // Arrange
          when(
            () => httpClient.post(
              any(),
              body: any(named: 'body'),
              headers: any(named: 'headers'),
            ),
          ).thenAnswer(
              (_) async => http.Response('Internal Server Error', 500));

          // Act
          final result = taskRemoteDataSource.createTask(
            title: 'title',
            tag: 'tag',
            createdAt: DateTime(2025, 07, 16),
          );

          // Assert
          expectLater(
            result,
            throwsA(
              APIException(
                  errorMessage: 'Internal Server Error', statusCode: 500),
            ),
          );

          verify(
            () => httpClient.post(
              Uri.parse('$kBaseUrl/tasks'),
              body: body,
              headers: {
                "content-type": "application/json",
              },
            ),
          ).called(1);
          verifyNoMoreInteractions(httpClient);
        },
      );
    },
  );

  group(
    'get all tasks',
    () {
      final testingTasks = [
        TaskModel(
          id: 0,
          title: 'title',
          tag: 'tag',
          createdAt: DateTime(2025, 07, 16),
        ),
      ];
      test(
        'should call server and return [List<TaskModel>] when call is successful',
        () async {
          // Arrange
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response(
              jsonEncode([testingTasks[0].toMap()]),
              200,
            ),
          );

          // Act
          final result = await taskRemoteDataSource.getAllTasks();

          // Assert
          expect(result, isA<List<TaskModel>>());
          verify(() => httpClient.get(Uri.parse('$kBaseUrl/tasks'))).called(1);
          verifyNoMoreInteractions(httpClient);
        },
      );

      test(
        'should call server and return [APIException] when call is not successful',
        () async {
          // Arrange
          when(() => httpClient.get(any())).thenAnswer(
            (_) async => http.Response('Internal Server Error', 500),
          );

          // Act
          final result = taskRemoteDataSource.getAllTasks();

          // Assert
          expectLater(
            result,
            throwsA(
              APIException(
                  errorMessage: 'Internal Server Error', statusCode: 500),
            ),
          );
          verify(() => httpClient.get(Uri.parse('$kBaseUrl/tasks'))).called(1);
          verifyNoMoreInteractions(httpClient);
        },
      );
    },
  );
}
