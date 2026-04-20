import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/error/exception.dart';
import 'package:taskora_app/core/error/failure.dart';
import 'package:taskora_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';
import 'package:taskora_app/features/auth/domain/entities/user.dart';
import 'package:taskora_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, AuthToken>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authToken = await remoteDataSource.login(
        email: email,
        password: password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', authToken.token);
      await prefs.setInt('WatchCost', authToken.watchCost);

      return Right(authToken);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message)); 
      }

      return const Left(ServerFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  }) async {
    try {
      await remoteDataSource.signUp(
        name: name,
        username: username,
        email: email,
        password: password,
        watchCost: watchCost,
      );
      return const Right(unit);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message)); // 🔥 ممكن تكون List أو String
      }

      return const Left(ServerFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failure, User>> forgotPassword({required String email}) async {
    if (email.isEmpty) {
      return const Left(ServerFailure('Invalid Forgot Password Data'));
    }

    try {
      final user = await remoteDataSource.forgotPassword(email: email);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    if (email.isEmpty || newPassword.isEmpty) {
      return const Left(ServerFailure('Email and password cannot be empty'));
    }

    try {
      await remoteDataSource.resetPassword(
        email: email,
        newPassword: newPassword,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyResetCode({required int code}) async {
    if (code <= 0) {
      return const Left(ServerFailure('Code cannot be empty or zero'));
    }

    try {
      final isVerified = await remoteDataSource.verifyResetCode(code: code);
      return Right(isVerified);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resendResetCode({required String email}) async {
    if (email.isEmpty) {
      return const Left(ServerFailure('Email cannot be empty'));
    }

    try {
      // استدعاء نفس دالة forgotPassword لإرسال الكود مرة ثانية
      await forgotPassword(email: email);
      return const Right(null); // نجاح العملية
    } catch (e) {
      return Left(ServerFailure(e.toString())); // رسالة الخطأ
    }
  }
}
