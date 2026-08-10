import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/projects/data/Model/project_model.dart';
import 'package:taskora_app/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/domain/repositories/project_repository.dart';

class ProjectRepositoriesImpl implements ProjectRepository {
  final ProjectsRemoteDataSource remoteDataSource;
  final SharedPreferences sharedPreferences;

  ProjectRepositoriesImpl({
    required this.remoteDataSource,
    required this.sharedPreferences,
  });
  @override
  Future<Either<Failure, List<ProjectEntity>>> getProjects() async {
    try {
      final String? token = sharedPreferences.getString('token');
      if (token == null || token.isEmpty) {
        return Left(ServerFailure('Token not found'));
      }

      List<ProjectModel> projects = await remoteDataSource.getProjacts(token);
      print(token);

      return Right(projects);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProjectEntity>> projectAdd({
    required String name,
    required String description,
    required String clientName,
    required String deadline,
  }) async {
    try {
      final String? token = sharedPreferences.getString('token');

      if (token == null || token.isEmpty) {
        return Left(ServerFailure('Token not found'));
      }

      final ProjectModel project = await remoteDataSource.projectAdd(
        token: token,
        name: name,
        description: description,
        clientName: clientName,
        deadline: deadline,
      );

      return Right(project);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
