import 'package:flutter/material.dart';

import 'level_mudah.dart';
import 'level_sedang.dart';
import 'level_sulit.dart';
import 'level_sangat_sulit.dart';

import 'homepage_(offline).dart';
import 'setting_(offline).dart';
import 'profil_(offline).dart';

class MenebakGambarPage extends StatelessWidget {
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
          "MENEBAK",
          style: TextStyle(
            letterSpacing: 15,
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
            "Pilih Level",
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

          // bagian level mudah
          levelButton(
            context: context,
            level: "MUDAH",
            title: "Ikan",
            imagePath: "img/ikan.png",
            targetPage: LevelMudahPage(),
            labelColor: Color(0xFF7EB142),
            labelAlignment: Alignment.topLeft,
          ),

          // bagian level normal
          levelButton(
            context: context,
            level: "SEDANG",
            title: "Burung",
            imagePath: "img/burung.png",
            targetPage: LevelSedangPage(),
            labelColor: Color(0xFFEBEF00),
            labelAlignment: Alignment.topLeft,
          ),

          // bagian level sedang
          levelButton(
            context: context,
            level: "SULIT",
            title: "Bunga",
            imagePath: "img/bunga.png",
            targetPage: LevelSulitPage(),
            labelColor: Color(0xFFF59A07),
            labelAlignment: Alignment.topLeft,
          ),

          // bagian level sulit
          levelButton(
            context: context,
            level: "SANGAT SULIT",
            title: "Tanaman Buah",
            imagePath: "img/tanaman_buah.png",
            targetPage: LevelSangatSulitPage(),
            labelColor: Color(0xFFFB1313),
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

  // widget level button
  Widget levelButton({
    required BuildContext context,
    required String level,
    required String title,
    required String imagePath,
    required Widget targetPage,
    required Color labelColor,
    required Alignment labelAlignment,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 25),
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

            // label level
            Positioned(
              top: -28,
              left: labelAlignment == Alignment.topLeft ? 20 : null,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: labelColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  level,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 3,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
