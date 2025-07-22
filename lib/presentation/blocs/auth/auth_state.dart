// lib/presentation/blocs/auth/auth_state.dart
part of 'auth_bloc.dart'; // <--- PASTIKAN INI ADALAH BARIS PERTAMA

// Abstract class dasar untuk semua state autentikasi
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// State awal sebelum ada operasi autentikasi
class AuthInitial extends AuthState {}

// State saat sedang dalam proses autentikasi (login/logout/cek status)
class AuthLoading extends AuthState {}

// State ketika pengguna berhasil terautentikasi
class AuthAuthenticated extends AuthState {
  // Anda bisa menambahkan data pengguna atau token di sini jika diperlukan
  // final UserEntity user;
  // const AuthAuthenticated({required this.user});
  // @override
  // List<Object> get props => [user];
}

// State ketika pengguna belum terautentikasi atau sesi berakhir
class AuthUnauthenticated extends AuthState {}

// State ketika terjadi error selama proses autentikasi
class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
