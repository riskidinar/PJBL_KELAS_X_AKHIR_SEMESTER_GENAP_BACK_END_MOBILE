import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';
import '../../sign_in/bindings/sign_in_binding.dart';
import '../../sign_in/views/sign_in_view.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

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

          // CONTENT
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 160),
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

                        // JUDUL
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Sign up",
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

                        // USERNAME
                        const Text(
                          "Username",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),

                        const SizedBox(height: 6),

                        _inputBox(
                          hint: "Username anda",
                          controller: controller.usernameController,
                        ),

                        const SizedBox(height: 12),

                        // EMAIL
                        const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
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
                          ),
                        ),

                        const SizedBox(height: 6),

                        _inputBox(
                          hint: "Password",
                          controller: controller.passwordController,
                          obscure: true,
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              SignInBinding().dependencies();
                              Get.to(() => const SignInView());
                            },
                            child: const Text(
                              "Sudah punya akun? Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.w300,
                                fontStyle:
                                    FontStyle.italic,
                                decoration:
                                    TextDecoration.underline,
                                decorationColor:
                                    Colors.white,
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // BUTTON REGISTER
                        Center(
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.register,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB9FF66),
                                ),
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.black,
                                      )
                                    : const Text(
                                        "Let’s go!",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
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
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
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