// lib/core/usecases/usecase.dart
import 'package:dartz/dartz.dart'; // Impor Dartz untuk Either
import 'package:equatable/equatable.dart'; // Impor Equatable
import '../errors/failures.dart'; // Impor kelas Failure kita

// Abstract class untuk UseCase base
// Type: Tipe data yang akan dikembalikan saat berhasil (misal: User, void, List<int>)
// Params: Tipe data untuk parameter input use case (misal: LoginParams, NoParams)
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

// Class untuk parameter kosong jika use case tidak memerlukan input
// Ini adalah implementasi standar Equatable untuk kelas tanpa properti
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object> get props => [];
}
