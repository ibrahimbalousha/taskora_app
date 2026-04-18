import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_token.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthToken>> call({
    required String email,
    required String password,
    required String username,
  }) {
    return repository.login(
      email: email,
      password: password,
      username: username,
    );
  }
}
