// lib/data/datasources/auth_remote_datasource.dart
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> signUp(String email, String password);
  Future<void> signOut();
  User? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('ไม่สามารถเข้าสู่ระบบได้: ${e.toString()}');
    }
  }

  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('ไม่สามารถสร้างบัญชีผู้ใช้ได้: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
