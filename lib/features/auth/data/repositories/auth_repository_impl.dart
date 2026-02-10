import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  @override
  Future<Either<Failure, AuthToken>> login({
    required String identifier,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // 🔐 mock validation
    if (identifier.isEmpty || password.isEmpty) {
      return const Left(
        ServerFailure('Email or password cannot be empty'),
      );
    }

    if (password != 'P@ssw0rd123') {
      return const Left(
        ServerFailure('Invalid credentials'),
      );
    }

    // ✅ success
    return Right(
      AuthToken(token: 'mock_access_token_123'),
    );
  }

  @override
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      return const Left(
        ServerFailure('Invalid signup data'),
      );
    }

    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword({
    required String identifier,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (identifier.isEmpty) {
      return const Left(
        ServerFailure('Identifier is required'),
      );
    }

    // training mode: code always sent (1234)
    return const Right(unit);
  }

  @override
  Future<Either<Failure, bool>> verifyResetCode({
    required String identifier,
    required String code,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    // training code
    if (code == '1234') {
      return const Right(true);
    } else {
      return const Left(
        ServerFailure('Invalid verification code'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String identifier,
    required String newPassword,
    required String resetCode,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (resetCode != '1234') {
      return const Left(
        ServerFailure('Invalid reset code'),
      );
    }

    if (newPassword.length < 6) {
      return const Left(
        ServerFailure('Password too short'),
      );
    }

    return const Right(unit);
  }
}
