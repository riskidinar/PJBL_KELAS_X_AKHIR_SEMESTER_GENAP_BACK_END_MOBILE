import 'package:flutter/material.dart';
import 'package:pjbl_backend_mobile_akhirsemestergenap_kelas_x/all_page/sign_in.dart';

// ganti dengan halaman tujuan
// import 'homepage.dart';
import 'homepage_(offline).dart';

class GuestMode extends StatelessWidget {
  const GuestMode({super.key});

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
                  const SizedBox(height: 140),

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
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: Column(
                            children: [
                              Image.asset(
                                "img/logo_wallacea_putih.png",
                                width: 95,
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "Anda sedang \n bermain mode \n Guest",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  height: 1.2,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        Center(
                          child: GestureDetector(
                            child: const Text(
                              "saat bermain mode guest progres skor \n anda tidak dapat tersimpan \n yakin ingin bermain mode guest ",
                              textAlign: TextAlign.center,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignInPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFB9FF66),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(18),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                  ),
                                  child: const Text(
                                    "Kembali",
                                    style: TextStyle(
                                      color:
                                          Colors.black, // ganti warna di sini
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomePageOffline(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB9FF66),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(18),
                                    ),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text(
                                  "Lanjutkan",
                                  style: TextStyle(
                                    color: Colors.black, // ganti warna di sini
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 60),

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
}
