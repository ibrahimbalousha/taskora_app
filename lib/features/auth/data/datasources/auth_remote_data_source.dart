import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:taskora_app/core/error/exception.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';
import 'package:taskora_app/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<AuthToken> login({required String email, required String password});
  Future<Unit> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  });

  Future<User> forgotPassword({required String email});
  Future<bool> verifyResetCode({required int code});

  Future<Unit> resetPassword({
    required String email,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static final http.Client _client = http.Client();

  @override
  Future<AuthToken> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('https://api.mohammedzomlot.dev/user/login');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return AuthToken(token: data['token'], watchCost: data['WatchCost']);
    } else {
      throw ServerException(data['message']);
    }
  }

  @override
  Future<User> forgotPassword({required String email}) async {
    final url = Uri.parse('https://api.mohammedzomlot.dev/user/forgotPassword');
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );
    final data = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return User(email: data['user']['email'], code: data['user']['code']);
    } else {
      throw Exception(data['message'] ?? 'forgotPassword failed');
    }
  }

  @override
  Future<Unit> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final url = Uri.parse('https://api.mohammedzomlot.dev/user/resetPassword');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'newPassword': newPassword}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Reset password failed');
    }
  }

  @override
  Future<Unit> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  }) async {
    final url = Uri.parse('https://api.mohammedzomlot.dev/user/signup');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'WatchCost': int.parse(watchCost),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else {
      final data = json.decode(response.body);

      if (data['errors'] != null && data['errors'] is List) {
        throw ServerException(data['errors']); // 🔥 List
      } else {
        throw ServerException(data['message'] ?? 'Something went wrong');
      }
    }
  }

  @override
  Future<bool> verifyResetCode({required int code}) async {
    final url = Uri.parse(
      'https://api.mohammedzomlot.dev/user/checkCodeController',
    );

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'code': code}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['status'] ?? false; // true إذا تحقق الكود
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'Verify reset code failed');
    }
  }
}
