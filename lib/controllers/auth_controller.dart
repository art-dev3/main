import 'package:get/get.dart';

import 'package:main/services/repositories/auth_repository/auth_repository.dart';
import 'package:main/services/repositories/auth_repository/auth_services.dart';

enum LoginStatus { idle, loading, success, failure, otpSent }

class AuthController extends GetxController {
  final AuthRepository authRepository;
  final AuthService authService;

  AuthController({required this.authRepository, required this.authService});

  // Observables
  var userStatus = 'unverified'.obs;
  var emailOrPhone = ''.obs;
  var password = ''.obs;
  var isTermsAccepted = false.obs;
  var status = LoginStatus.idle.obs;
  var errorMessage = ''.obs;

  var verificationId = ''.obs;
  var resendToken = Rxn<int>();
  var isOtpMode = false.obs;

  // Check if input is phone
  bool get isPhone => authService.isPhone(emailOrPhone.value);

  /// Login Handler
  Future<void> login() async {
    status.value = LoginStatus.loading;
    final input = emailOrPhone.value.trim();

    try {
      await authRepository.signInWithEmailAndPassword(
        email: input,
        password: password.value.trim(),
      );
      status.value = LoginStatus.success;
    } catch (e) {
      status.value = LoginStatus.failure;
      errorMessage.value = _formatError(e);
    }
  }

  Future<void> fetchUserStatus() async {
    await Future.delayed(const Duration(seconds: 1));
    userStatus.value = 'verified'; // or 'underVerification'
  }

  String _formatError(Object e) {
    return e.toString().replaceFirst('Exception: ', '');
  }
}
