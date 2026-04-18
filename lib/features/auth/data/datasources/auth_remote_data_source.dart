import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';

abstract class AuthRemoteDataSource {
  Future<AuthToken> login({
    required String email,
    required String password,
    required String username,
  });
  Future<Unit> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  });

  Future<Unit> forgotPassword({
    required String email,
    required String name,
    required String username,
  });

  Future<Unit> resetPassword({
    required String email,
    required String newPassword,
    required String resetCode,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static final http.Client _client = http.Client();

  @override
  Future<AuthToken> login({
    required String email,
    required String password,
    required String username,
  }) async {
    final url = Uri.parse('https://api.mohammedzomlot.dev/user/login');

    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'username': username,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return AuthToken(token: data['token']);
    } else {
      throw Exception('Login failed');
    }
  }

  @override
  Future<Unit> forgotPassword({
    required String email,
    required String name,
    required String username,
  }) async {
    final url = Uri.parse(
      'https://api.mohammedzomlot.dev/project/forgotPassword',
    );
    final response = await _client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'name': name, 'username': username}),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return unit;
    } else {
      final data = json.decode(response.body);
      throw Exception(data['message'] ?? 'forgotPassword failed');
    }
  }

  @override
  Future<Unit> resetPassword({
    required String email,
    required String newPassword,
    required String resetCode,
  }) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Unit> signUp({
    required String name,
    required String username,
    required String email,
    required String password,
    required String watchCost,
  }) async {
    final url = Uri.parse('https://api.mohammedzomlot.dev/auth/signup');

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
      throw Exception(data['message'] ?? 'Sign up failed');
    }
  }
}
