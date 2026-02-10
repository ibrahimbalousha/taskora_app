abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String identifier;
  final String password;

  LoginEvent({
    required this.identifier,
    required this.password,
  });
}
class SignUpEvent extends AuthEvent {
  final String name;
  final String username;
  final String identifier;
  final String password;

  SignUpEvent({
    required this.name,
    required this.username,
    required this.identifier,
    required this.password,
  });
}

class ForgotPasswordEvent extends AuthEvent {
  final String identifier;

  ForgotPasswordEvent({required this.identifier});
}

class VerifyResetCodeEvent extends AuthEvent {
  final String identifier;
  final String code;

  VerifyResetCodeEvent({
    required this.identifier,
    required this.code,
  });
}

class ResetPasswordEvent extends AuthEvent {
  final String identifier;
  final String newPassword;
  final String resetCode;

  ResetPasswordEvent({
    required this.identifier,
    required this.newPassword,
    required this.resetCode,
  });
}
