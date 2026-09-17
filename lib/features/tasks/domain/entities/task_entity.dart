class TaskEntity {
  final String id;
  final String projectId;
  final String name;
  final String description;
  final String priority;
  final num totalHours;
  final String status;

  const TaskEntity({
    required this.id,
    required this.projectId,
    required this.name,
    required this.description,
    required this.priority,
    required this.totalHours,
    required this.status,
  });
}
