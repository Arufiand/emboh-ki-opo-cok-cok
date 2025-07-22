// lib/core/utils/hive_config.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan direktori penyimpanan

class HiveConfig {
  static const String SETTINGS_BOX =
      'settingsBox'; // Nama box untuk pengaturan umum
  static const String AUTH_BOX =
      'authBox'; // Nama box untuk data autentikasi (opsional, bisa digabung)

  static Future<void> init() async {
    // Dapatkan direktori dokumen aplikasi untuk penyimpanan Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Daftarkan TypeAdapters jika Anda memiliki objek custom yang akan disimpan di Hive
    // Hive.registerAdapter(YourCustomObjectModelAdapter());

    // Buka box-box yang akan digunakan
    await Hive.openBox<String>(
      SETTINGS_BOX,
    ); // Contoh box untuk string (pengaturan)
    await Hive.openBox<String>(AUTH_BOX); // Contoh box untuk string (token)
    // Atau jika hanya satu box umum:
    // await Hive.openBox('appBox');
  }

  // Metode untuk menutup semua box saat aplikasi ditutup (opsional tapi baik)
  static Future<void> dispose() async {
    await Hive.close();
  }
}
