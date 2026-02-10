abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {}

class VerifyResetCodeSuccess extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class LoginSuccess extends AuthState {}


class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
