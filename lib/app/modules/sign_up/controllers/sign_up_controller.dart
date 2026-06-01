import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../../../services/auth_service.dart';
import '/../../all_page/homepage.dart';

class SignUpController extends GetxController {

  // TEXT CONTROLLER
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // LOADING
  RxBool isLoading = false.obs;

  // AUTH SERVICE
  final authService = AuthService();

  // REGISTER
  Future<void> register() async {
    try {
      isLoading.value = true;
      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // VALIDASI USERNAME
      if (username.isEmpty) {
        Get.snackbar(
          "Error",
          "Username wajib diisi",
        );
        return;
      }
      if (username.contains(' ')) {
        Get.snackbar(
          "Error",
          "Username tidak boleh memakai spasi",
        );

        return;
      }
      if (username.length < 3) {
        Get.snackbar(
          "Error",
          "Username minimal 3 karakter",
        );
        return;
      }

      // VALIDASI EMAIL
      if (email.isEmpty) {
        Get.snackbar(
          "Error",
          "Email wajib diisi",
        );
        return;
      }

      // VALIDASI PASSWORD
      if (password.length < 6) {
        Get.snackbar(
          "Error",
          "Password minimal 6 karakter",
        );
        return;
      }

      // REGISTER
      final error = await authService.signUp(
        username: username,
        email: email,
        password: password,
      );

      // BERHASIL
      if (error == null) {
        Get.snackbar(
          "Berhasil",
          "Register berhasil",
        );
        Get.offAll(() => const HomePage());
      }

      // GAGAL
      else {
        Get.snackbar(
          "Register gagal",
          error,
        );
      }

    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}