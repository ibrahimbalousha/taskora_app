import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/domain/repositories/task_repository.dart';

class GetTasksUseCase {
  final TaskRepository repository;

  const GetTasksUseCase(this.repository);

  Future<Either<Failure, List<TaskEntity>>> call({required String projectId}) async {
    return await repository.getTasks(projectId: projectId);
  }
}
