part of 'ip_config_bloc.dart';

// Abstract class dasar untuk semua state konfigurasi IP
abstract class IpConfigState extends Equatable {
  const IpConfigState();

  @override
  List<Object> get props => [];
}

// State awal sebelum ada operasi yang dilakukan
class IpConfigInitial extends IpConfigState {}

// State saat sedang memuat atau menyimpan data
class IpConfigLoading extends IpConfigState {}

// State saat URL API berhasil dimuat
class IpConfigLoaded extends IpConfigState {
  final AppConfigEntity appConfig;

  const IpConfigLoaded({required this.appConfig});

  @override
  List<Object> get props => [appConfig];
}

// State saat operasi penyimpanan berhasil
class IpConfigSavedSuccess extends IpConfigState {
  final String message;
  const IpConfigSavedSuccess({this.message = 'Konfigurasi berhasil disimpan!'});

  @override
  List<Object> get props => [message];
}

// State saat terjadi error
class IpConfigError extends IpConfigState {
  final String message;

  const IpConfigError({required this.message});

  @override
  List<Object> get props => [message];
}
