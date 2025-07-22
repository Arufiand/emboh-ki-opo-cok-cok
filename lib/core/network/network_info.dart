// lib/core/network/network_info.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart'; // Import Dio
import 'dio_client.dart'; // Import DioClient yang sudah kita buat

abstract class NetworkInfo {
  // Mengecek koneksi internet secara umum
  Future<bool> hasInternetConnection();
  // Mengecek apakah API backend dapat dijangkau
  Future<bool> isBackendReachable();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
  final DioClient _dioClient; // Tambahkan DioClient sebagai dependency

  NetworkInfoImpl(this._connectivity, this._dioClient);

  @override
  Future<bool> hasInternetConnection() async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Future<bool> isBackendReachable() async {
    // Pertama, pastikan ada koneksi internet
    if (!(await hasInternetConnection())) {
      return false;
    }

    try {
      // Coba lakukan permintaan GET yang sangat ringan ke endpoint "health check" atau "ping" API Anda.
      // Endpoint ini idealnya tidak memerlukan autentikasi dan hanya mengembalikan status 200 OK.
      // Misalnya: GET /health atau GET /ping
      final response = await _dioClient.dio.get(
        '/health',
      ); // Asumsi ada endpoint /health

      // Jika status code 200, berarti API dapat dijangkau
      return response.statusCode == 200;
    } on DioException catch (e) {
      // Tangani error jaringan (timeout, host not found, dll.)
      // print('Error checking backend reachability: $e');
      return false;
    } catch (e) {
      // Tangani error lain
      // print('Unexpected error checking backend reachability: $e');
      return false;
    }
  }
}
