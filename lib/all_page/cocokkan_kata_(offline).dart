import 'package:flutter/material.dart';

import 'jenis_mamalia.dart';
import 'jenis_pohon.dart';
import 'jenis_reptil.dart';
import 'jenis_tanaman_obat.dart';

import 'setting_(offline).dart';
import 'homepage_(offline).dart';
import 'profil_(offline).dart';

void main() {
  runApp(const CocokkanPage());
}

class CocokkanPage extends StatelessWidget {
  const CocokkanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF7EB142),
        centerTitle: true,
        leading: BackButton(
          color: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "COCOKKAN",
          style: TextStyle(
            letterSpacing: 13,
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 50),
          Text(
            "Pilih Jenis",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 70),

          // bagian Mamalia
          JenisButton(
            context: context,
            title: "Mamalia",
            imagePath: "img/mamalia.png",
            targetPage: MencocokkanMamaliaPage(),
            labelAlignment: Alignment.topLeft,
          ),

          // bagian Tanaman Obat
          JenisButton(
            context: context,
            title: "Pohon",
            imagePath: "img/pohon.png",
            targetPage: MencocokkanPohonPage(),
            labelAlignment: Alignment.topLeft,
          ),

          // bagian Reptil
          JenisButton(
            context: context,
            title: "Reptil",
            imagePath: "img/reptil.png",
            targetPage: MencocokkanReptilPage(),
            labelAlignment: Alignment.topLeft,
          ),

          // bagian Pohon
          JenisButton(
            context: context,
            title: "Tanaman Obat",
            imagePath: "img/tanaman_obat.png",
            targetPage: MencocokkanTanamanPage(),
            labelAlignment: Alignment.topLeft,
          ),
        ],
      ),

      // navbar
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF3E7B27),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // tombol setting
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SetingPageOffline()),
                );
              },
              child: Image.asset("img/icon_seting.png", width: 40),
            ),

            // tombol home
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomePageOffline()),
                );
              },
              child: Image.asset("img/icon_homepage.png", width: 50),
            ),

            // tombol profil
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
    );
  }

  // widget Jenis button
  Widget JenisButton({
    required BuildContext context,
    required String title,
    required String imagePath,
    required Widget targetPage,
    required Alignment labelAlignment,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 1, 20, 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => targetPage),
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFFBEEC1),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // warna shadow
                    blurRadius: 4, // lembut / blur
                    offset: Offset(0, 3), // arah bayangan (x, y)
                  ),
                ],
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Image.asset(imagePath, width: 70, height: 70),
                  const SizedBox(width: 50),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 23,
                      color: Color(0xFF4F7F1F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
