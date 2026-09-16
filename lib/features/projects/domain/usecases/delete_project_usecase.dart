import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/projects/domain/repositories/project_repository.dart';

class DeleteProjectUseCase {
  final ProjectRepository repository;

  const DeleteProjectUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String id}) async {
    return await repository.deleteProject(id: id);
  }
}
