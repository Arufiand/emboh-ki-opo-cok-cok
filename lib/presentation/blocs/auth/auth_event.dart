// lib/presentation/blocs/auth/auth_event.dart
part of 'auth_bloc.dart'; // <--- PASTIKAN INI ADALAH BARIS PERTAMA

// Abstract class dasar untuk semua event autentikasi
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Event yang dipicu ketika pengguna mencoba login
class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

// Event yang dipicu ketika pengguna mencoba logout
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

// Event yang dipicu untuk memeriksa status autentikasi saat aplikasi dimulai
class CheckAuthStatusRequested extends AuthEvent {
  const CheckAuthStatusRequested();
}
