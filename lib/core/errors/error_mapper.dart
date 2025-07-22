import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Exception e) {
  if (e is ServerException) return ServerFailure(e.message);
  if (e is CacheException) return CacheFailure(e.message);
  if (e is NetworkException) return NetworkFailure(e.message);
  return ServerFailure('Unexpected error occurred');
}
