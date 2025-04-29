// lib/domain/usecases/sign_up.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<String, UserEntity>> call(String email, String password) {
    return repository.signUp(email, password);
  }
}