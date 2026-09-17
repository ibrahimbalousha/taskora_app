import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/tasks/data/datasources/tasks_remote_data_source.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoriesImpl implements TaskRepository {
  final TasksRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  TaskRepositoriesImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });

  String? get _token => sharedPreferences.getString('token');

  @override
  Future<Either<Failure, List<TaskEntity>>> getTasks({required String projectId}) async {
    try {
      final token = _token;
      if (token == null || token.isEmpty) {
        return Left(ServerFailure('Token not found'));
      }

      final tasks = await remoteDataSource.getTasks(token: token, projectId: projectId);
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> addTask({
    required String projectId,
    required String name,
    required String description,
    required String priority,
    required num totalHours,
    required String status,
  }) async {
    try {
      final token = _token;
      if (token == null || token.isEmpty) {
        return Left(ServerFailure('Token not found'));
      }

      final task = await remoteDataSource.addTask(
        token: token,
        body: {
          '_id_projact': projectId,
          'name': name,
          'Dcrshin': description,
          'imprtn': priority,
          'TotalHuwe': totalHours,
          'MissionStatus': status,
        },
      );

      return Right(task);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> updateTask({
    required String id,
    String? name,
    String? description,
    String? priority,
    num? totalHours,
    String? status,
  }) async {
    try {
      final token = _token;
      if (token == null || token.isEmpty) {
        return Left(ServerFailure('Token not found'));
      }

      final body = <String, dynamic>{'_id': id};
      if (name != null) body['name'] = name;
      if (description != null) body['Dcrshin'] = description;
      if (priority != null) body['imprtn'] = priority;
      if (totalHours != null) body['TotalHuwe'] = totalHours;
      if (status != null) body['MissionStatus'] = status;

      final task = await remoteDataSource.updateTask(token: token, body: body);

      return Right(task);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask({required String id}) async {
    try {
      final token = _token;
      if (token == null || token.isEmpty) {
        return Left(ServerFailure('Token not found'));
      }

      await remoteDataSource.deleteTask(token: token, id: id);

      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
