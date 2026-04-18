import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
    required String username,
  });
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  });

  Future<Either<Failure, Unit>> forgotPassword({
    required String email,
    required String name,
    required String username,
  });

  Future<Either<Failure, bool>> verifyResetCode({
    required String email,
    required String code,
  });

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
    required String resetCode,
  });
}
