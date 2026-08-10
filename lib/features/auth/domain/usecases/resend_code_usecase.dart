import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class ResendCodeUseCase {
  final AuthRepository _repository;

  ResendCodeUseCase(this._repository);

  Future<Either<Failure, void>> call(String email) {
    return _repository.resendResetCode( email: email);
  }
}