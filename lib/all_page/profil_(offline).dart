import 'package:flutter/material.dart';
import 'jelajahi_sekarang.dart';  // ganti dengan halaman tujuanmu


class ProfilPageOffline extends StatelessWidget {
  const ProfilPageOffline ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8DBA43),

      body: SafeArea(
        child: Column(
          children: [

            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ===== FOTO PROFIL =====
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("img/icon_profil.png"),
            ),

            const SizedBox(height: 25),

            // Teks
            const Text(
              "Guest",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 120),

            const Text(
              "Sign in untuk membuka\nfitur lainnya!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 370),

            // ===== LOGOUT =====
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JelajahiSekarang(), // tujuan logout
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "img/icon_logout.png",
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}