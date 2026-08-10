import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String newPassword,
  }) {
    return repository.resetPassword(
      email: email,
      newPassword: newPassword,
    );
  }
}
