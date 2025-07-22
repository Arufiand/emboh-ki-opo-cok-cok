// lib/presentation/blocs/ip_config/ip_config_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/errors/failures.dart'; // Import Failure
import '../../../core/usecases/usecase.dart'; // Import NoParams
import '../../../domain/entities/app_config.dart'; // Import AppConfigEntity
import '../../../domain/usecases/get_api_url.dart'; // Import GetApiUrl use case
import '../../../domain/usecases/save_api_url.dart'; // Import SaveApiUrl use case

// Part files untuk event dan state (pastikan nama file sesuai)
// Ini adalah directive yang memberitahu Dart bahwa file-file di bawah adalah bagian dari library ini.
part 'ip_config_event.dart';
part 'ip_config_state.dart';

class IpConfigBloc extends Bloc<IpConfigEvent, IpConfigState> {
  final GetApiUrl _getApiUrl;
  final SaveApiUrl _saveApiUrl;

  // Constructor: menginjeksi use case yang dibutuhkan dan menentukan state awal
  IpConfigBloc({
    required GetApiUrl getApiUrl,
    required SaveApiUrl saveApiUrl,
  })  : _getApiUrl = getApiUrl,
        _saveApiUrl = saveApiUrl,
        super(IpConfigInitial()) {
    // Mendaftarkan handler untuk setiap event
    on<GetIpConfigRequested>(_onGetIpConfigRequested);
    on<SaveIpConfigRequested>(_onSaveIpConfigRequested);
  }

  // Handler untuk event GetIpConfigRequested
  Future<void> _onGetIpConfigRequested(
    GetIpConfigRequested event,
    Emitter<IpConfigState> emit,
  ) async {
    emit(IpConfigLoading()); // Emit state loading
    final result = await _getApiUrl(const NoParams()); // Panggil use case
    result.fold(
      (failure) => emit(IpConfigError(
          message: _mapFailureToMessage(failure))), // Jika gagal, emit error
      (appConfig) => emit(
          IpConfigLoaded(appConfig: appConfig)), // Jika berhasil, emit loaded
    );
  }

  // Handler untuk event SaveIpConfigRequested
  Future<void> _onSaveIpConfigRequested(
    SaveIpConfigRequested event,
    Emitter<IpConfigState> emit,
  ) async {
    emit(IpConfigLoading()); // Emit state loading
    final result = await _saveApiUrl(
        SaveApiUrlParams(apiUrl: event.apiUrl)); // Panggil use case
    result.fold(
      (failure) => emit(IpConfigError(
          message: _mapFailureToMessage(failure))), // Jika gagal, emit error
      (_) => emit(const IpConfigSavedSuccess()), // Jika berhasil, emit success
    );
  }

  // Helper function untuk memetakan Failure ke pesan yang lebih mudah dibaca
  String _mapFailureToMessage(Failure failure) {
    if (failure is CacheFailure) {
      return failure.message;
    } else if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return failure.message;
    }
    return 'Terjadi kesalahan tidak dikenal.';
  }
}
