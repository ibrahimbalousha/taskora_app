import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failuer.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl  implements AuthRepository{
  @override
  Future<Either<Failuer, Unit>> forgotPassword({required String identifier}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failuer, AuthToken>> login({required String identifier, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Either<Failuer, Unit>> resetPassword({required String identifier, required String newPassword, required String resetCode}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failuer, Unit>> signUp({required String name, required String username, required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}