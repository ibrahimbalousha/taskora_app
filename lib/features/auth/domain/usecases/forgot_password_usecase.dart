import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String identifier,
  }) {
    return repository.forgotPassword(
      identifier: identifier,
    );
  }
}
