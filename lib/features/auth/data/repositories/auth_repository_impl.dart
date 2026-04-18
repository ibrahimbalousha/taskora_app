import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final authToken = await remoteDataSource.login(
        email: email,
        password: password,
        username: username,
      );
      return Right(authToken);
    } catch (e) {
      return Left(ServerFailure('Login failed'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left(ServerFailure('Invalid Signup Data'));
    }

    return Right(
      await remoteDataSource.signUp(
        name: name,
        username: username,
        email: email,
        password: password,
        watchCost: watchCost,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({
    required String email,
    required String name,
    required String username,
  }) async {
    if (email.isEmpty || name.isEmpty || username.isEmpty) {
      return const Left(ServerFailure('Invalid Forgot Password Data'));
    }

    return Right(
      await remoteDataSource.forgotPassword(
        email: email,
        name: name,
        username: username,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
    required String resetCode,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> verifyResetCode({
    required String email,
    required String code,
  }) {
    // TODO: implement verifyResetCode
    throw UnimplementedError();
  }
}
