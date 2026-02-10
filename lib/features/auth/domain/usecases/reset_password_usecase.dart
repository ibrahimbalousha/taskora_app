import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/Failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String identifier,
    required String newPassword,
    required String resetCode,
  }) {
    return repository.resetPassword(
      identifier: identifier,
      newPassword: newPassword,
      resetCode: resetCode,
    );
  }
}
