import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:taskora_app/core/config/constants/request_constants.dart';
import 'package:taskora_app/features/projects/data/Model/project_model.dart';

abstract class ProjectsRemoteDataSource {
  Future<List<ProjectModel>> getProjacts(String token);
  Future<ProjectModel> projectAdd({
    required String token,
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  });
  Future<Unit> deleteProject({required String token, required String id});
  Future<Unit> updateProject({required String token, required Map<String, dynamic> body});
}

String _errorMessage(Map<String, dynamic> body, String fallback) {
  final errors = body['errors'];
  if (errors is List && errors.isNotEmpty) {
    return errors.join('\n');
  }
  return body['message'] ?? fallback;
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  final http.Client client;

  ProjectsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProjectModel>> getProjacts(String token) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/see/getProjact');
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> projectsJson = responseBody['data'] ?? [];
      return projectsJson
          .map<ProjectModel>(
            (project) => ProjectModel.fromJson(project as Map<String, dynamic>),
          )
          .toList();
    }

    throw Exception(_errorMessage(responseBody, 'Failed to get projects'));
  }

  @override
  Future<ProjectModel> projectAdd({
    required String token,
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/project/add');
    final response = await client.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'client': clientName,
        'deadline': deadline,
      }),
    );
    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");
    final Map<String, dynamic> responseBody = response.body.isNotEmpty
        ? jsonDecode(response.body) as Map<String, dynamic>
        : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final dynamic projectData = responseBody['data'] ?? responseBody;

      if (projectData is! Map<String, dynamic>) {
        throw Exception('Invalid project data returned from server');
      }

      return ProjectModel.fromJson(projectData);
    }

    throw Exception(_errorMessage(responseBody, 'Failed to add project'));
  }

  @override
  Future<Unit> deleteProject({
    required String token,
    required String id,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/project/romve/$id');
    final response = await client.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return unit;
    }

    final Map<String, dynamic> responseBody = response.body.isNotEmpty
        ? jsonDecode(response.body) as Map<String, dynamic>
        : {};
    throw Exception(_errorMessage(responseBody, 'Failed to delete project'));
  }

  @override
  Future<Unit> updateProject({
    required String token,
    required Map<String, dynamic> body,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}/project/updatProject');
    final response = await client.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return unit;
    }

    final Map<String, dynamic> responseBody = response.body.isNotEmpty
        ? jsonDecode(response.body) as Map<String, dynamic>
        : {};
    throw Exception(_errorMessage(responseBody, 'Failed to update project'));
  }
}
