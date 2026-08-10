import 'dart:convert';

import 'package:http/http.dart' as http;
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
}

class ProjectsRemoteDataSourceImpl implements ProjectsRemoteDataSource {
  final http.Client client;

  ProjectsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProjectModel>> getProjacts(String token) async {
    final url = Uri.parse('http://localhost:3500/see/getProjact');
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

    throw Exception(responseBody['message'] ?? 'Failed to get projects');
  }

  @override
  Future<ProjectModel> projectAdd({
    required String token,
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  }) async {
    final url = Uri.parse('http://localhost:3500/project/add');
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

    throw Exception(responseBody['message'] ?? 'Failed to add project');
  }
}
