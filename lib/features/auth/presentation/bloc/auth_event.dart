abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;

  LoginEvent({
    required this.email,
    required this.password,
    required this.username,
  });
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String username;
  final String email;
  final String password;
  final String watchCost;

  SignUpEvent({
    required this.watchCost,
    required this.name,
    required this.username,
    required this.email,
    required this.password,
  });
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  final String name;
  final String username;

  ForgotPasswordEvent({
    required this.email,
    required this.name,
    required this.username,
  });
}

class VerifyResetCodeEvent extends AuthEvent {
  final String email;
  final String code;

  VerifyResetCodeEvent({required this.email, required this.code});
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;
  final String resetCode;

  ResetPasswordEvent({
    required this.email,
    required this.newPassword,
    required this.resetCode,
  });
}
