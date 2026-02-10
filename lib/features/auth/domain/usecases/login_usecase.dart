import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_token.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call({
    required String identifier,
    required String password,
  }) {
    return repository.login(
      identifier: identifier,
      password: password,
    );
  }
}
