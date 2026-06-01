import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_in_controller.dart';
import '../../sign_up/bindings/sign_up_binding.dart';
import '../../sign_up/views/sign_up_view.dart';
import '/../../all_page/guest_mode.dart';


class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/signin_and_signup.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // KONTEN
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120),

                  // CARD LOGIN
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7EB142),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        // JUDUL + LOGO
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 45,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                "img/logo_wallacea_putih.png",
                                width: 95,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 10),

                        // EMAIL
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        _inputBox(
                          hint: "Email anda",
                          controller: controller.emailController,
                        ),

                        const SizedBox(height: 12),

                        // PASSWORD
                        const Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 6),

                        _inputBox(
                          hint: "Password",
                          controller: controller.passwordController,
                          obscure: true,
                        ),

                        const SizedBox(height: 20),

                        // BUTTON LOGIN
                        Center(
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB9FF66),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(18),
                                    ),
                                  ),
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : const Text(
                                        "Let’s go!",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 19),

                        // KE HALAMAN REGISTER
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              SignUpBinding().dependencies();
                              Get.to(() => const SignUpView());
                            },
                            child: const Text(
                              "Belum punya akun? Daftar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // GUEST MODE
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8DBA43),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "ATAU",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Get.to(() => const GuestMode());
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "img/icon_profil.png",
                                width: 28,
                              ),
                            ),
                            label: const Text("Lanjutkan dengan Guest Mode"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFB9FF66),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // INPUT BOX
  Widget _inputBox({
    required String hint,
    required TextEditingController controller,
    bool obscure = false,
  }) {
    return Container(
      width: 330,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF7EB142),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
