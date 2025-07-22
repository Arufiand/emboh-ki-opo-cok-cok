// lib/presentation/pages/ip_config_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Untuk navigasi kembali
import 'package:flutter_bloc/flutter_bloc.dart'; // Import flutter_bloc
import 'package:get_it/get_it.dart'; // Import GetIt untuk mendapatkan instance Bloc

import '../blocs/ip_config/ip_config_bloc.dart'; // Import IpConfigBloc

class IpConfigPage extends StatefulWidget {
  const IpConfigPage({super.key});

  @override
  State<IpConfigPage> createState() => _IpConfigPageState();
}

class _IpConfigPageState extends State<IpConfigPage> {
  final TextEditingController _ipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dispatch event untuk mengambil URL API yang tersimpan saat halaman dimuat
    // Menggunakan WidgetsBinding.instance.addPostFrameCallback untuk memastikan context tersedia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<IpConfigBloc>().add(const GetIpConfigRequested());
    });
  }

  @override
  void dispose() {
    _ipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Membungkus seluruh halaman dengan BlocProvider agar IpConfigBloc tersedia
    // Kemudian menggunakan BlocConsumer untuk mendengarkan perubahan state dan membangun UI
    return BlocProvider(
      create: (context) => GetIt.instance<
          IpConfigBloc>(), // Mendapatkan instance Bloc dari GetIt
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Konfigurasi API Backend'),
        ),
        body: BlocConsumer<IpConfigBloc, IpConfigState>(
          listener: (context, state) {
            // Listener untuk bereaksi terhadap perubahan state (misal: menampilkan SnackBar, navigasi)
            if (state is IpConfigLoaded) {
              // Jika data berhasil dimuat, isi TextFormField
              _ipController.text = state.appConfig.apiUrl;
            } else if (state is IpConfigSavedSuccess) {
              // Jika penyimpanan berhasil
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.green,
                ),
              );
              context.pop(); // Kembali ke halaman sebelumnya setelah menyimpan
            } else if (state is IpConfigError) {
              // Jika terjadi error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            // Builder untuk membangun UI berdasarkan state saat ini
            bool isLoading = state is IpConfigLoading;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Masukkan Alamat URL API Backend:',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: _ipController,
                    enabled: !isLoading, // Nonaktifkan saat loading
                    decoration: InputDecoration(
                      hintText: 'http://192.168.1.100:8080/api',
                      labelText: 'URL API Backend',
                      border: const OutlineInputBorder(),
                      suffixIcon: isLoading
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : null,
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null // Nonaktifkan tombol saat loading
                        : () {
                            // Dispatch event SaveIpConfigRequested saat tombol ditekan
                            context.read<IpConfigBloc>().add(
                                  SaveIpConfigRequested(
                                      apiUrl: _ipController.text),
                                );
                          },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2),
                          )
                        : const Text(
                            'Simpan Konfigurasi',
                            style: TextStyle(fontSize: 16.0),
                          ),
                  ),
                  const SizedBox(height: 10.0),
                  OutlinedButton(
                    onPressed: isLoading
                        ? null // Nonaktifkan tombol saat loading
                        : () {
                            // Tombol "Batal" / Navigasi kembali
                            context
                                .pop(); // GoRouter untuk kembali ke halaman sebelumnya
                          },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: const Text(
                      'Batal',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
