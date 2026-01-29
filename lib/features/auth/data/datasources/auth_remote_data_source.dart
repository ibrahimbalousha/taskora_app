import 'package:dartz/dartz.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';

abstract class AuthRemoteDataSource {
  Future<AuthToken> login({
    required String identifier,
    required String password,
  });
  Future<Unit> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
  });

  Future<Unit> forgotPassword({required String identifier});

  Future<Unit> resetPassword({
    required String identifier,
    required String newPassword,
    required String resetCode,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{
  @override
  Future<Unit> forgotPassword({required String identifier}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<AuthToken> login({required String identifier, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Unit> resetPassword({required String identifier, required String newPassword, required String resetCode}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Unit> signUp({required String name, required String username, required String email, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
