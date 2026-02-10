import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyResetCodeUseCase verifyResetCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthBloc({
    required this.forgotPasswordUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<ForgotPasswordEvent>(_onForgotPassword);
    on<VerifyResetCodeEvent>(_onVerifyResetCode);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await forgotPasswordUseCase(
      identifier: event.identifier,
    );

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
      identifier: event.identifier,
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
      identifier: event.identifier,
      newPassword: event.newPassword,
      resetCode: event.resetCode,
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
