// lib/domain/repositories/auth_repository.dart
import 'package:dartz/dartz.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> signIn(String email, String password);
  Future<Either<String, UserEntity>> signUp(String email, String password);
  Future<void> signOut();
  UserEntity? getCurrentUser();
}