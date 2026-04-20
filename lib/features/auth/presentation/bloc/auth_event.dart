abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({
    required this.email,
    required this.password,
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

  ForgotPasswordEvent({
    required this.email,
  });
}

class VerifyResetCodeEvent extends AuthEvent {
  final int code;

  VerifyResetCodeEvent({required this.code});
}
class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;

  ResetPasswordEvent({
    required this.email,
    required this.newPassword,
  });
}

class ResendCodeEvent extends AuthEvent {
  final String email;
  ResendCodeEvent({required this.email});
}

class ResetAuthState extends AuthEvent {}