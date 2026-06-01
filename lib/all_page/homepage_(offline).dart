import 'package:flutter/material.dart';
import 'notifikasi.dart';
import 'menebak_gambar.dart';
import 'cocokkan_kata.dart';
import 'profil_(offline).dart';
import 'setting_(offline).dart';

class HomePageOffline extends StatelessWidget {
  const HomePageOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= BODY =================
      body: Column(
        children: [

          // ===== HEADER =====
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: const BoxDecoration(
              color: Color(0xFF8DBA43),
            ),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // teks kiri
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Halo!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Apa yang ingin kamu mainkan ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  // avatar
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage("img/icon_profil.png",),
                  ),
                ],
              ),
            ),
          ),

          // ===== ICON NOTIF =====
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NotifikasiPage()),
                  );
                },
                child: Image.asset(
                  "img/icon_notifikasi.png",
                  width: 45,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // ===== JUDUL =====
          const Text(
            "PILIH JENIS GAME !",
            style: TextStyle(
              color: Color(0xFF6AAE2F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic
            ),
          ),

          const SizedBox(height: 45),

          // ===== CARD GAME =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              // MENEBak GAMBAR
              _gameCard(
                context: context,
                image: "img/icon_menebak.png",
                title: "MENEBAK\nGAMBAR",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MenebakGambarPage(),
                    ),
                  );
                },
              ),

              // COCOKKAN KATA
              _gameCard(
                context: context,
                image: "img/icon_mencocokkan.png",
                title: "COCOKKAN\nKATA",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CocokkanPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),

      // ================= NAVBAR (PUNYA KAMU) =================
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFF3E7B27),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SetingPageOffline()),
                  );
                },
                child: Image.asset("img/icon_seting.png", width: 40),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomePageOffline()),
                  );
                },
                child: Image.asset("img/icon_homepage.png", width: 50),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilPageOffline()),
                  );
                },
                child: Image.asset("img/icon_profil.png", width: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD GAME =================
  Widget _gameCard({
    required BuildContext context,
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 175,
            height: 175,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3C6),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 5,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Image.asset(image),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF3E7B27),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}