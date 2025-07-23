// lib/presentation/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/errors/failures.dart';
import '../../../domain/usecases/login_user.dart';
import '../../../domain/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser _loginUser;
  final AuthRepository _authRepository;

  AuthBloc({
    required LoginUser loginUser,
    required AuthRepository authRepository,
  })  : _loginUser = loginUser,
        _authRepository = authRepository,
        super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatusRequested>(_onCheckAuthStatusRequested);
  }

  // Handler untuk event LoginRequested
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final params = LoginParams(
      username: event.username,
      password: event.password,
    );

    final result = await _loginUser(params);

    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (_) => emit(AuthAuthenticated()),
    );
  }

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
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      await _authRepository.logout();
      emit(AuthUnauthenticated());
    } on Failure catch (e) {
      emit(AuthError(message: _mapFailureToMessage(e)));
    }
  }

  Future<void> _onCheckAuthStatusRequested(
    CheckAuthStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading()); // Emit state loading

    // Hapus simulasi Future.delayed ini jika Anda sudah memiliki logika autentikasi sebenarnya.
    // await Future.delayed(const Duration(milliseconds: 500)); // Simulasi

    // Panggil use case/repository dan dapatkan hasilnya (Either<Failure, bool>)
    final result =
        await _authRepository.checkAuthStatus(); // <-- Diperbaiki di sini

    // Gunakan fold() untuk menangani kedua kemungkinan hasil dari Either
    result.fold(
      // Sisi KIRI (Failure): Jika operasi gagal
      (failure) => emit(AuthError(
          message: _mapFailureToMessage(failure))), // Emit state Error
      // Sisi KANAN (bool): Jika operasi berhasil
      (isAuthenticated) {
        if (isAuthenticated) {
          emit(AuthAuthenticated()); // Emit state Authenticated
        } else {
          emit(AuthUnauthenticated()); // Emit state Unauthenticated
        }
      },
    );
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
