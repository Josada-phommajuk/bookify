
// lib/domain/usecases/sign_in.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
