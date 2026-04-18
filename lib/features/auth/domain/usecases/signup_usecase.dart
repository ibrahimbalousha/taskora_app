import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  }) {
    return repository.signUp(
      name: name,
      username: username,
      email: email,
      password: password,
      watchCost: watchCost,
    );
  }
}
