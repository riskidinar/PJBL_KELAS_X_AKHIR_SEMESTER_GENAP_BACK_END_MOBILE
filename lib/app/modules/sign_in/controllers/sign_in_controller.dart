import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../../../services/auth_service.dart';
import '/../../all_page/homepage.dart';

class SignInController extends GetxController {

  // INPUT CONTROLLER
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // LOADING
  RxBool isLoading = false.obs;

  // AUTH SERVICE
  final authService = AuthService();

  // LOGIN
  Future<void> login() async {
    try {
      isLoading.value = true;
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // VALIDASI
      if(email.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Error",
          "Email dan password wajib diisi",
        );
        return;
      }

      // LOGIN
      final error = await authService.signIn(
        email: email,
        password: password,
      );

      // BERHASIL
      if(error == null) {
        Get.snackbar(
          "Berhasil",
          "Login berhasil",
        );
       Get.offAll(() => const HomePage());
      }

      // GAGAL
      else {
        Get.snackbar(
          "Login gagal",
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
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}