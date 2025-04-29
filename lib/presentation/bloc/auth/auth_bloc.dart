// lib/presentation/bloc/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_current_user.dart';
import '../../../domain/usecases/sign_in.dart';
import '../../../domain/usecases/sign_out.dart';
import '../../../domain/usecases/sign_up.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
    required this.getCurrentUserUseCase,
  }) : super(AuthInitialState()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
  }

  void _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) {
    final currentUser = getCurrentUserUseCase();
    if (currentUser != null) {
      emit(AuthenticatedState(currentUser));
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _onSignIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await signInUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthErrorState(failure)),
      (user) => emit(AuthenticatedState(user)),
    );
  }

  Future<void> _onSignUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await signUpUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthErrorState(failure)),
      (user) => emit(AuthenticatedState(user)),
    );
  }

  Future<void> _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    await signOutUseCase();
    emit(UnauthenticatedState());
  }
}
