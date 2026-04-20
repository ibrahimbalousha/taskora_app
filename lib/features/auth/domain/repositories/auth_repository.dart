import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';
import 'package:taskora_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  });

  Future<Either<Failure, User>> forgotPassword({required String email});

  Future<Either<Failure, bool>> verifyResetCode({required int code});

  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
  });
  Future<Either<Failure, void>> resendResetCode({required String email});
}
