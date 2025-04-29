// lib/data/models/user_model.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String uid;
  final String email;

  const UserModel({
    required this.uid,
    required this.email,
  });

  factory UserModel.fromFirebaseUser(user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
    );
  }

  @override
  List<Object?> get props => [uid, email];
}