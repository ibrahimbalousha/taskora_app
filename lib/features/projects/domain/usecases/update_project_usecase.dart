import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/projects/domain/repositories/project_repository.dart';

class UpdateProjectUseCase {
  final ProjectRepository repository;

  const UpdateProjectUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String id,
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  }) async {
    return await repository.updateProject(
      id: id,
      name: name,
      description: description,
      clientName: clientName,
      deadline: deadline,
    );
  }
}
