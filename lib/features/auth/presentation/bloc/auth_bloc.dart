// lib/features/auth/presentation/bloc/auth_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthBootstrapRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  AuthLoginRequested(this.email, this.password);
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class AuthRegisterRequested extends AuthEvent {
  AuthRegisterRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
  final String email, password, firstName, lastName;
}

class AuthLogoutRequested extends AuthEvent {}

class AuthLogoutAllRequested extends AuthEvent {}

class AuthRefreshUserRequested extends AuthEvent {}

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final User user;
  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated([this.message]);
  final String? message;
  @override
  List<Object?> get props => [message];
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repo) : super(AuthInitial()) {
    on<AuthBootstrapRequested>(_onBootstrap);
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
    on<AuthLogoutAllRequested>(_onLogoutAll);
    on<AuthRefreshUserRequested>(_onRefreshUser);
  }
  final AuthRepository _repo;

  Future<void> _onBootstrap(_, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await _repo.bootstrap();
    emit(user == null ? const AuthUnauthenticated() : AuthAuthenticated(user));
  }

  Future<void> _onLogin(AuthLoginRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repo.login(e.email, e.password);
      emit(AuthAuthenticated(user));
    } catch (err) {
      emit(AuthUnauthenticated(err.toString()));
    }
  }

  Future<void> _onRegister(
      AuthRegisterRequested e, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _repo.register(
        email: e.email,
        password: e.password,
        firstName: e.firstName,
        lastName: e.lastName,
      );
      emit(AuthAuthenticated(user));
    } catch (err) {
      emit(AuthUnauthenticated(err.toString()));
    }
  }

  Future<void> _onLogout(_, Emitter<AuthState> emit) async {
    await _repo.logout();
    emit(const AuthUnauthenticated());
  }

  Future<void> _onLogoutAll(_, Emitter<AuthState> emit) async {
    await _repo.logoutAll();
    emit(const AuthUnauthenticated());
  }

  Future<void> _onRefreshUser(_, Emitter<AuthState> emit) async {
    if (state is! AuthAuthenticated) return;
    try {
      final user = await _repo.getCurrentUser();
      emit(AuthAuthenticated(user));
    } catch (_) {
      // keep current state on transient errors; 401 handled by interceptor
    }
  }
}
