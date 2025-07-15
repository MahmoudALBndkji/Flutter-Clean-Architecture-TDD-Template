import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_clean_architecture_tdd_template/core/utils/constants.dart';
import 'package:flutter_clean_architecture_tdd_template/core/errors/exceptions.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/models/task_model.dart';
import 'package:flutter_clean_architecture_tdd_template/features/tasks/data/datasources/task_data_source.dart';

class TaskRemoteDataSource implements TaskDataSource {
  final http.Client _client;
  const TaskRemoteDataSource(this._client);

  @override
  Future<void> createTask({
    required String title,
    required String tag,
    required DateTime createdAt,
  }) async {
    final String createdAtString = createdAt.toIso8601String();
    final body = jsonEncode(
      {
        "tag": tag,
        "title": title,
        "createdAt": createdAtString,
      },
    );
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl/tasks'),
        body: body,
        headers: {
          "content-type": "application/json",
        },
      );
      if (!_isRequestSuccess(response.statusCode)) {
        throw APIException(
          errorMessage: 'Internal Server Error',
          statusCode: response.statusCode,
        );
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(errorMessage: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final response = await _client.get(Uri.parse('$kBaseUrl/tasks'));
      if (!_isRequestSuccess(response.statusCode)) {
        throw APIException(
          errorMessage: 'Internal Server Error',
          statusCode: response.statusCode,
        );
      }
      final responseBody = response.body;
      final responseObjs = jsonDecode(responseBody) as List<dynamic>;
      final result = responseObjs.map((obj) => TaskModel.fromMap(obj)).toList();
      return result;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(errorMessage: e.toString(), statusCode: 505);
    }
  }

  bool _isRequestSuccess(int statusCode) =>
      statusCode >= 200 && statusCode <= 299;
}
