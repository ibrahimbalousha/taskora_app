import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/tasks/domain/repositories/task_repository.dart';

class DeleteTaskUseCase {
  final TaskRepository repository;

  const DeleteTaskUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String id}) async {
    return await repository.deleteTask(id: id);
  }
}
