// lib/data/datasources/local/auth_local_datasource.dart
import 'package:hive_flutter/hive_flutter.dart'; // Impor Hive
import '../../../core/errors/failures.dart'; // Impor CacheFailure

abstract class AuthLocalDataSource {
  Future<void> saveLoginStatus(bool isLoggedIn);

  Future<bool> getLoginStatus();

  Future<void> clearLoginStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<String> authBox;

  AuthLocalDataSourceImpl({required this.authBox});

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
