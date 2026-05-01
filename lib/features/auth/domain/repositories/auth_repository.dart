import 'package:myfinanceapp/features/auth/domain/entities/auth_tokens.dart';
import 'package:myfinanceapp/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(
      {required String email,
      required String password,
      required String firstName,
      required String lastName});
  Future<void> logout();
  Future<void> logoutAll();
  Future<User?> bootstrap();
  Future<User> getCurrentUser();
  Future<AuthTokens?> currentTokens();
}
