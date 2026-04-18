import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final LoginUseCase loginUseCase;
  final SignupUseCase signUpUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SignUpEvent>(_onSignUp);
  }
  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await signUpUseCase(
      name: event.name,
      username: event.username,
      email: event.email,
      password: event.password,
      watchCost: event.watchCost,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(SignUpSuccess()),
    );
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      email: event.email,
      password: event.password,
      username: event.username,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (authToken) => emit(LoginSuccess(authToken: authToken)),
    );
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await forgotPasswordUseCase(email: event.email,name: event.name,username: event.username);

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(ForgotPasswordSuccess()),
    );
  }

  Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await verifyResetCodeUseCase(
      email: event.email,
      code: event.code,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(VerifyResetCodeSuccess()),
    );
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await resetPasswordUseCase(
      email: event.email,
      newPassword: event.newPassword,
      resetCode: event.resetCode,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
