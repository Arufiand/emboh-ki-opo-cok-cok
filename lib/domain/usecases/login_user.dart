// lib/domain/usecases/login_user.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/repositories/auth_repository.dart'; // <--- Import AuthRepository

class LoginUser implements UseCase<void, LoginParams> {
  final AuthRepository repository; // <--- Sekarang membutuhkan AuthRepository

  const LoginUser(this.repository); // <--- Injeksi AuthRepository

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    // Memanggil metode login dari repository
    return await repository.login(params.username, params.password);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}
