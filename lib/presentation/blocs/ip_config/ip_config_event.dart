// lib/presentation/blocs/ip_config/ip_config_event.dart
part of 'ip_config_bloc.dart';

// Abstract class dasar untuk semua event konfigurasi IP
abstract class IpConfigEvent extends Equatable {
  const IpConfigEvent();

  @override
  List<Object> get props => [];
}

// Event untuk memuat (mengambil) URL API yang tersimpan
class GetIpConfigRequested extends IpConfigEvent {
  const GetIpConfigRequested();
}

// Event untuk menyimpan URL API yang baru
class SaveIpConfigRequested extends IpConfigEvent {
  final String apiUrl; // URL API yang ingin disimpan

  const SaveIpConfigRequested({required this.apiUrl});

  @override
  List<Object> get props => [apiUrl];
}
