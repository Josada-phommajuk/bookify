// lib/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, UserEntity>> signIn(String email, String password) async {
    try {
      final result = await remoteDataSource.signIn(email, password);
      final user = UserModel.fromFirebaseUser(result.user).toEntity();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> signUp(String email, String password) async {
    try {
      final result = await remoteDataSource.signUp(email, password);
      final user = UserModel.fromFirebaseUser(result.user).toEntity();
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  UserEntity? getCurrentUser() {
    final user = remoteDataSource.getCurrentUser();
    if (user != null) {
      return UserModel.fromFirebaseUser(user).toEntity();
    }
    return null;
  }
}
