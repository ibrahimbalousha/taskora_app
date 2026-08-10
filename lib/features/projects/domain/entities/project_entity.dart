class ProjectEntity {
  final String id;
  final String userId;
  final String name;
  final DateTime deadline;
  final String description;
  final String client;
  final num watchCost;

  const ProjectEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.deadline,
    required this.description,
    required this.client,
    required this.watchCost,
  });
}
