import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  final AuthRepository repository;

  VerifyResetCodeUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String email,
    required String code,
  }) {
    return repository.verifyResetCode(
      email: email,
      code: code,
    );
  }
}
