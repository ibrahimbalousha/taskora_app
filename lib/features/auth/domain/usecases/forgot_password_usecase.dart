import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String name,
    required String username,
  }) {
    return repository.forgotPassword(
      email: email,
      name: name,
      username: username,
    );
  }
}
