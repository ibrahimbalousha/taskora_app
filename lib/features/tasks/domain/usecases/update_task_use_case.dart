import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  const UpdateTaskUseCase(this.repository);

  Future<Either<Failure, TaskEntity>> call({
    required String id,
    String? name,
    String? description,
    String? priority,
    num? totalHours,
    String? status,
  }) async {
    return await repository.updateTask(
      id: id,
      name: name,
      description: description,
      priority: priority,
      totalHours: totalHours,
      status: status,
    );
  }
}
