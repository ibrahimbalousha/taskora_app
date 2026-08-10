import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/domain/repositories/project_repository.dart';

class ProjectAddUesCase {
  final ProjectRepository repositories;

  ProjectAddUesCase({required this.repositories});

  Future<Either<Failure, ProjectEntity>> call({
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  }) async {
    return await repositories.projectAdd(
      name: name,
      description: description,
      clientName: clientName,
      deadline: deadline,
    );
  }
}
