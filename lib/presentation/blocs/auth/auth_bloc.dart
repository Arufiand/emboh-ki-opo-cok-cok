// lib/presentation/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart'; // Untuk Either dan unit

import '../../../core/errors/failures.dart'; // Import Failure
import '../../../domain/usecases/login_user.dart'; // Import LoginUser use case
// Import UseCase untuk check status / logout jika ada
// import '../../../domain/usecases/check_auth_status.dart';
// import '../../../domain/usecases/logout_user.dart';
import '../../../domain/repositories/auth_repository.dart'; // Import AuthRepository untuk metode logout/cek status

// Part files untuk event dan state
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser _loginUser;
  final AuthRepository _authRepository; // Untuk logout dan check status

  AuthBloc({
    required LoginUser loginUser,
    required AuthRepository authRepository, // Injeksi AuthRepository
  })  : _loginUser = loginUser,
        _authRepository = authRepository,
        super(AuthInitial()) {
    // Mendaftarkan handler untuk setiap event
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(
        _onLogoutRequested); // Akan kita tambahkan logikanya nanti
    on<CheckAuthStatusRequested>(
        _onCheckAuthStatusRequested); // Akan kita tambahkan logikanya nanti
  }

  // Handler untuk event LoginRequested
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading()); // Emit state loading

    final params = LoginParams(
      username: event.username,
      password: event.password,
    );

    final result = await _loginUser(params); // Panggil LoginUser use case

    result.fold(
      (failure) => emit(AuthError(
          message: _mapFailureToMessage(failure))), // Jika gagal, emit error
      (_) => emit(AuthAuthenticated()), // Jika berhasil, emit authenticated
    );
  }

  // Handler untuk event LogoutRequested (akan diimplementasikan nanti)
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Implementasi logika logout dari _authRepository
    // final result = await _authRepository.logout();
    // result.fold(
    //   (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
    //   (_) => emit(AuthUnauthenticated()),
    // );
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi
    try {
      await _authRepository.logout(); // Panggil metode logout dari repository
      emit(AuthUnauthenticated()); // Set state menjadi tidak terautentikasi
    } on Failure catch (e) {
      emit(AuthError(message: _mapFailureToMessage(e)));
    }
  }

  // Handler untuk event CheckAuthStatusRequested (akan diimplementasikan nanti)
  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Implementasi logika cek status autentikasi dari _authRepository
    // final result = await _authRepository.checkAuthStatus();
    // result.fold(
    //   (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
    //   (isAuthenticated) {
    //     if (isAuthenticated) {
    //       emit(AuthAuthenticated());
    //     } else {
    //       emit(AuthUnauthenticated());
    //     }
    //   },
    // );
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi
    try {
      final bool isAuthenticated = await _authRepository
          .checkAuthStatus(); // Panggil metode check status
      if (isAuthenticated) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    } on Failure catch (e) {
      emit(AuthError(message: _mapFailureToMessage(e)));
    }
  }

  // Helper function untuk memetakan Failure ke pesan yang lebih mudah dibaca
  String _mapFailureToMessage(Failure failure) {
    if (failure is AuthFailure) {
      return failure.message;
    } else if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return failure.message;
    }
    return 'Terjadi kesalahan tidak dikenal.';
  }
}
