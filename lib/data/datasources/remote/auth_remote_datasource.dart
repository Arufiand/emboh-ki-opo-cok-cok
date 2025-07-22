// lib/data/datasources/remote/auth_remote_datasource.dart
// import 'package:dio/dio.dart'; // Uncomment jika sudah menggunakan Dio secara langsung
import '../../../core/errors/failures.dart'; // Impor ServerFailure
import '../../../core/network/dio_client.dart'; // Impor DioClient, jika digunakan

// Abstract class untuk AuthRemoteDataSource
// Ini adalah kontrak untuk operasi data remote terkait autentikasi (misal: login API).
abstract class AuthRemoteDataSource {
  // Metode untuk melakukan login melalui API.
  // Akan mengembalikan void jika login berhasil.
  // Akan melempar Failure jika ada masalah (jaringan, kredensial salah dari API, dll).
  Future<void> login(String username, String password);

  // Future<void> logout(); // Akan ditambahkan nanti untuk logout API
  // Future<bool> checkTokenValidity(String token); // Akan ditambahkan nanti untuk validasi token
}

// Implementasi AuthRemoteDataSource yang akan berinteraksi dengan API.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // DioClient akan diinjeksi dan digunakan untuk melakukan panggilan HTTP.
  final DioClient dioClient;

  AuthRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<void> login(String username, String password) async {
    // --- Ini adalah implementasi sementara (placeholder) ---
    // Di masa depan, kode ini akan berisi panggilan HTTP POST ke API login.
    // Misalnya:
    /*
    try {
      final response = await dioClient.post(
        '/auth/login', // Ganti dengan endpoint API login Anda
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Jika sukses (misalnya, API mengembalikan token), bisa diproses di sini.
        // Misalnya: final token = response.data['token'];
        return; // Login berhasil, tidak ada yang perlu dikembalikan.
      } else if (response.statusCode == 401) {
        throw const ServerFailure('Kredensial tidak valid dari API.');
      } else {
        throw ServerFailure('Gagal login server: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      // Tangani error jaringan atau server
      if (e.type == DioErrorType.connectionError) {
        throw const NetworkFailure('Tidak ada koneksi internet.');
      }
      if (e.response?.statusCode == 401) {
        throw const ServerFailure('Username atau password salah.');
      }
      throw ServerFailure('Kesalahan komunikasi dengan server: ${e.message}');
    } catch (e) {
      throw ServerFailure('Terjadi kesalahan tidak dikenal: $e');
    }
    */

    // Untuk saat ini, kita akan melempar kesalahan atau mengembalikan void
    // untuk mensimulasikan kegagalan/keberhasilan remote yang belum diimplementasikan.
    await Future.delayed(const Duration(seconds: 1)); // Simulasi delay jaringan

    // Contoh: selalu melempar error untuk menunjukkan API belum siap
    throw const ServerFailure('Fungsi login API belum diimplementasikan.');

    // Atau, jika Anda ingin mensimulasikan keberhasilan dummy:
    // return;
  }
}
