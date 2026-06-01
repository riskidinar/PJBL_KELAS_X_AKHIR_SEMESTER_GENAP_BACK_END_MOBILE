import 'package:flutter/material.dart';
// import 'package:pjbl_backend_mobile_akhirsemestergenap_kelas_x/all_page/sign_in.dart';

// ganti dengan halaman tujuan
// import 'homepage.dart';
import 'guest_mode.dart';

class DeteksiOffline extends StatelessWidget {
  const DeteksiOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ===== BACKGROUND =====
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/signin_and_signup.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ===== KONTEN =====
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 105),

                  // ===== CARD SIGN IN =====
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

                        // judul + logo
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              Image.asset(
                                "img/logo_wallacea_putih.png",
                                width: 95,
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "Anda Sedang Offline !",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Center(
                          child: GestureDetector(
                            child: const Text(
                              "Harap periksa koneksi internet anda",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.italic,
                                // decoration:
                                //     TextDecoration.underline, //  underline
                                // decorationColor:
                                //     Colors.white, //  warna underline
                                decorationThickness: 2,
                              ),
                            ),
                          ),
                        ),

                        // forgot password
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (_) => const ForgotPasswordPage(),
                        //         ),
                        //       );
                        //     },
                        //     child: const Text(
                        //       "Lupa password?",
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //         fontSize: 11,
                        //         decoration: TextDecoration.underline,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 50),

                        // KEMBALI BUTTON
                        Center(
                          child: SizedBox(
                            width: 150,
                            height: 50,
                            // child: ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (_) => const SignInPage(),
                            //       ),
                            //     );
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: const Color(0xFFB9FF66),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.only(
                            //         topLeft: Radius.circular(18),
                            //         topRight: Radius.circular(20),
                            //         bottomLeft: Radius.circular(20),
                            //         bottomRight: Radius.circular(18),
                            //       ),
                            //     ),
                            //     padding: const EdgeInsets.symmetric(
                            //       vertical: 12,
                            //     ),
                            //   ),
                            //   child: const Text(
                            //     "Kembali",
                            //     style: TextStyle(
                            //       color: Colors.black, // ganti warna di sini
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.bold,
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),

                  // ===== CARD BAWAH =====
                  const SizedBox(height: 30),

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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const GuestMode(),
                                ),
                              );
                            },

                            icon: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Image.asset(
                                "img/icon_profil.png",
                                width: 28,
                                fit: BoxFit.contain,
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

  // ===== INPUT BOX =====
  // Widget _inputBox({required String hint}) {
  //   return Container(
  //     width: 330,
  //     height: 45, //  atur lebar di sini
  //     decoration: BoxDecoration(
  //       color: Color(0xFF7EB142), //  warna background
  //       borderRadius: BorderRadius.circular(15),
  //       border: Border.all(
  //         color: Colors.black, //  warna border
  //         width: 2,
  //       ),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.3), // warna bayangan
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: TextField(
  //       textAlignVertical: TextAlignVertical.center,
  //       decoration: InputDecoration(
  //         hintText: hint,
  //         hintStyle: const TextStyle(color: Colors.white),
  //         border: InputBorder.none,
  //         contentPadding: const EdgeInsets.symmetric(
  //           horizontal: 16,
  //           vertical: 10,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
