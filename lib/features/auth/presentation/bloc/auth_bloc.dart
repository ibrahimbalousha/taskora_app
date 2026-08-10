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
  String? currentEmail;
  AuthBloc({
    required this.signUpUseCase,
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.verifyResetCodeUseCase,
    required this.resetPasswordUseCase,
  }) : super(AuthInitial()) {
    on<ResendCodeEvent>((ResendCodeEvent event, Emitter<AuthState> emit) async {
      emit(AuthLoading());
      try {
        await forgotPasswordUseCase(email: event.email); // نفس الدالة
        emit(ForgotPasswordSuccess(email: event.email)); // البريد محفوظ
      } catch (e) {
        emit(ResetPasswordError(e.toString()));
      }
    });
    on<ResetAuthState>((event, emit) {
      emit(AuthInitial());
    });
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
  (failure) {
    if (failure.message is List) {
      final errors = (failure.message as List).join('\n');
      emit(SignUpError(errors)); // ✅ String
    } else {
      emit(SignUpError(failure.message.toString()));
    }
  },
  (_) => emit(SignUpSuccess(message: 'Account created successfully')),
);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(LoginError(failure.message)),
      (authToken) => emit(LoginSuccess(authToken: authToken)),
    );
  }

  Future<void> _onForgotPassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await forgotPasswordUseCase(email: event.email);

    result.fold(
      (failure) {
        emit(
          ForgotPasswordError(failure.message.replaceAll('Exception: ', '')),
        );
      },
      (user) {
        currentEmail = user.email;
        emit(ForgotPasswordSuccess(email: user.email)); // ✅ الإيميل موجود
      },
    );
  }

  Future<void> _onVerifyResetCode(
    VerifyResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await verifyResetCodeUseCase(code: event.code);

    result.fold(
      (failure) => emit(VerifyCodeError(failure.message)),
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
    );

    result.fold(
      (failure) => emit(ResetPasswordError(failure.message)),
      (_) => emit(ResetPasswordSuccess()),
    );
  }
}
