import 'package:firebase_auth/firebase_auth.dart';
import 'package:main/model/user_model/user_model.dart';
import 'package:main/services/repositories/auth_repository/auth_services.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  // Login with Email and Password
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> registerWithEmail(String email, String password) async {
    await authService.registerWithEmail(email, password);
  }

  // Get the currently authenticated user
  // Future<User?> getCurrentUser() async {
  //   return await authService.getCurrentUser();
  // }

  // Log out the current user
  // Future<void> signOut() async {
  //   await authService.signOut();
  // }

  Future<UserModel> getUserById(String userId) async {
    return await authService.getUserById(userId);
  }
}
