import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  const TaskModel({
    required super.id,
    required super.projectId,
    required super.name,
    required super.description,
    required super.priority,
    required super.totalHours,
    required super.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'] as String,
      projectId: json['_id_projact'] as String,
      name: json['name'] as String,
      description: json['Dcrshin'] as String? ?? '',
      priority: json['imprtn'] as String? ?? 'medium',
      totalHours: num.tryParse(json['TotalHuwe']?.toString() ?? '0') ?? 0,
      status: json['MissionStatus'] as String? ?? 'to-do',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'Dcrshin': description,
      'imprtn': priority,
      'TotalHuwe': totalHours,
      'MissionStatus': status,
      '_id_projact': projectId,
    };
  }
}
