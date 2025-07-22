// lib/core/errors/failures.dart
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure([this.message = 'Terjadi kesalahan tidak terduga']);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Gagal terhubung ke server.']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Gagal menyimpan data lokal.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Tidak ada koneksi internet.']);
}

// --- Tambahan untuk Autentikasi ---
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Username atau password salah.']);
}



// Tambahkan failure lainnya sesuai kebutuhan