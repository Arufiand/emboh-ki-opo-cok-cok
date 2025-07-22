// lib/data/datasources/local/auth_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart'; // Impor Hive
import '../../../core/errors/failures.dart'; // Impor CacheFailure

// Abstract class untuk AuthLocalDataSource
// Ini adalah kontrak untuk operasi data lokal terkait autentikasi.
abstract class AuthLocalDataSource {
  // Metode untuk menyimpan status login pengguna (true jika sudah login, false jika belum)
  Future<void> saveLoginStatus(bool isLoggedIn);

  // Metode untuk mendapatkan status login pengguna
  // Mengembalikan true jika pengguna sudah login, false jika belum.
  Future<bool> getLoginStatus();

  // Metode untuk menghapus status login (untuk logout)
  Future<void> clearLoginStatus();
}

// Implementasi AuthLocalDataSource yang menggunakan Hive.
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // Box Hive yang akan digunakan untuk menyimpan/mengambil status autentikasi.
  // Ini akan diinjeksi melalui GetIt, dan kita sudah mendaftarkan AUTH_BOX sebagai Box<String>.
  final Box<String> authBox;

  // Constructor untuk menginjeksi Hive Box
  AuthLocalDataSourceImpl({required this.authBox});

  // Key untuk menyimpan status login di dalam Hive Box
  static const String _isLoggedInKey = 'isLoggedIn';

  @override
  Future<void> saveLoginStatus(bool isLoggedIn) async {
    try {
      // Simpan nilai boolean sebagai string ('true' atau 'false')
      await authBox.put(_isLoggedInKey, isLoggedIn.toString());
    } catch (e) {
      // Tangani error jika penyimpanan ke Hive gagal
      throw CacheFailure('Gagal menyimpan status login lokal: $e');
    }
  }

  @override
  Future<bool> getLoginStatus() async {
    try {
      // Ambil status dari Hive. Jika tidak ada, get akan mengembalikan null.
      final String? status = authBox.get(_isLoggedInKey);
      // Konversi string kembali ke boolean. Jika null, berarti belum login, jadi false.
      return status == 'true';
    } catch (e) {
      // Tangani error jika pengambilan dari Hive gagal
      throw CacheFailure('Gagal mengambil status login lokal: $e');
    }
  }

  @override
  Future<void> clearLoginStatus() async {
    try {
      // Hapus status login dari Hive untuk proses logout
      await authBox.delete(_isLoggedInKey);
    } catch (e) {
      // Tangani error jika penghapusan dari Hive gagal
      throw CacheFailure('Gagal menghapus status login lokal: $e');
    }
  }
}
