import 'package:taskora_app/features/auth/domain/entities/auth_token.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String email;
  ForgotPasswordSuccess({required this.email});
}

class VerifyResetCodeSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class LoginSuccess extends AuthState {
  final AuthToken authToken;

  LoginSuccess({required this.authToken});
}

class SignUpSuccess extends AuthState {
  final String message;

  SignUpSuccess({this.message = 'Sign up successful!'});
}
class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}

class ForgotPasswordError extends AuthState {
  final String message;
  ForgotPasswordError(this.message);
}

class VerifyCodeError extends AuthState {
  final String message;
  VerifyCodeError(this.message);
}

class ResetPasswordError extends AuthState {
  final String message;
  ResetPasswordError(this.message);
}