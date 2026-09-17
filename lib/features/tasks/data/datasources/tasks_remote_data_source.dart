import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskora_app/core/config/constants/request_constants.dart';
import 'package:taskora_app/features/tasks/data/Model/task_model.dart';

abstract class TasksRemoteDataSource {
  Future<List<TaskModel>> getTasks({required String token, required String projectId});

  Future<TaskModel> addTask({required String token, required Map<String, dynamic> body});

  Future<TaskModel> updateTask({required String token, required Map<String, dynamic> body});

  Future<void> deleteTask({required String token, required String id});
}

String _errorMessage(Map<String, dynamic> body, String fallback) {
  final errors = body['errors'];
  if (errors is List && errors.isNotEmpty) {
    return errors.join('\n');
  }
  return body['message'] ?? fallback;
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSource {
  final http.Client client;

  TasksRemoteDataSourceImpl({required this.client});

  Map<String, String> _headers(String token) => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

  @override
  Future<List<TaskModel>> getTasks({
    required String token,
    required String projectId,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/task/gettask/$projectId');
    final response = await client.get(url, headers: _headers(token));
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> tasksJson = responseBody['tasks'] ?? [];
      return tasksJson
          .map<TaskModel>((task) => TaskModel.fromJson(task as Map<String, dynamic>))
          .toList();
    }

    if (response.statusCode == 404) {
      return [];
    }

    throw Exception(_errorMessage(responseBody, 'Failed to get tasks'));
  }

  @override
  Future<TaskModel> addTask({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/task/add');
    final response = await client.post(
      url,
      headers: _headers(token),
      body: jsonEncode(body),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return TaskModel.fromJson(responseBody['task'] as Map<String, dynamic>);
    }

    throw Exception(_errorMessage(responseBody, 'Failed to add task'));
  }

  @override
  Future<TaskModel> updateTask({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/task/updateTask');
    final response = await client.patch(
      url,
      headers: _headers(token),
      body: jsonEncode(body),
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return TaskModel.fromJson(responseBody['updatedTask'] as Map<String, dynamic>);
    }

    throw Exception(_errorMessage(responseBody, 'Failed to update task'));
  }

  @override
  Future<void> deleteTask({required String token, required String id}) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/task/removeTask/$id');
    final response = await client.delete(url, headers: _headers(token));

    if (response.statusCode == 200) {
      return;
    }

    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    throw Exception(_errorMessage(responseBody, 'Failed to delete task'));
  }
}
