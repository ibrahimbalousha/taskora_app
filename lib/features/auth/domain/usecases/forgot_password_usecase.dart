import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/domain/entities/user.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, User>> call({
    required String email,
  }) {
    return repository.forgotPassword(
      email: email,
    );
  }
}
