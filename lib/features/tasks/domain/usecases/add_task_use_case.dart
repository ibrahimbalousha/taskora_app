import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository repository;

  const AddTaskUseCase(this.repository);

  Future<Either<Failure, TaskEntity>> call({
    required String projectId,
    required String name,
    required String description,
    required String priority,
    required num totalHours,
    required String status,
  }) async {
    return await repository.addTask(
      projectId: projectId,
      name: name,
      description: description,
      priority: priority,
      totalHours: totalHours,
      status: status,
    );
  }
}
