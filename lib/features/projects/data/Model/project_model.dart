import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.deadline,
    required super.description,
    required super.client,
    required super.watchCost,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['_id'] as String,
      userId: json['_id_user'] as String,
      name: json['name'] as String,
      deadline: DateTime.parse(json['deadline'] as String),
      description: json['description'] as String,
      client: json['client'] as String,
      watchCost: num.tryParse(json['watchCost']?.toString() ?? '0') ?? 0,
    );
  }
}
