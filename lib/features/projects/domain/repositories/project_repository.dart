import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/project_entity.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<ProjectEntity>>> getProjects();
  Future<Either<Failure, ProjectEntity>> projectAdd({
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  });
  Future<Either<Failure, Unit>> deleteProject({required String id});
  Future<Either<Failure, Unit>> updateProject({
    required String id,
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  });
}
