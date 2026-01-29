import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failuer.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<Either<Failuer, AuthToken>>login({
    required String identifier,
    required String password,
  });
  Future<Either<Failuer, Unit>> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
  });

  Future<Either<Failuer, Unit>> forgotPassword({required String identifier});

  Future<Either<Failuer, Unit>> resetPassword({
    required String identifier,
    required String newPassword,
    required String resetCode,
  });
}
