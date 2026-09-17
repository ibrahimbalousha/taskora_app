import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task_entity.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getTasks({required String projectId});

  Future<Either<Failure, TaskEntity>> addTask({
    required String projectId,
    required String name,
    required String description,
    required String priority,
    required num totalHours,
    required String status,
  });

  Future<Either<Failure, TaskEntity>> updateTask({
    required String id,
    String? name,
    String? description,
    String? priority,
    num? totalHours,
    String? status,
  });

  Future<Either<Failure, Unit>> deleteTask({required String id});
}
