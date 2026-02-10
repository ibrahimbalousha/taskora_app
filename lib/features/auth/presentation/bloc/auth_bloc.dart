import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // TODO: call LoginUseCase
    await Future.delayed(const Duration(seconds: 1));

    emit(AuthSuccess());
  }

  Future<void> _onSignUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    // TODO: call SignUpUseCase
    await Future.delayed(const Duration(seconds: 1));

    emit(AuthSuccess());
  }

  void _onLogout(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitial());
  }
}
