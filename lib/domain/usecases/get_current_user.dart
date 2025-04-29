// lib/domain/usecases/get_current_user.dart
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  UserEntity? call() {
    return repository.getCurrentUser();
  }
}