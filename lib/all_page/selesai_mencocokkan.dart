import 'package:flutter/material.dart';
import 'cocokkan_kata.dart';
import 'homepage.dart';



class GameSelesaiPage extends StatelessWidget {
  final int score;

  const GameSelesaiPage({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7EB142),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3C6),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Text(
                "Selesai! Mau coba jenis yang lain?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF3E7B27),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                children: [
                  SizedBox(height: 5),
                  Text(
                    "Total Skor Level ini",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "$score", // contoh skor yang nanti bisa di ubah sistem
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 22),
                ],
              ),
            ),

            const SizedBox(height: 40),

             Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                    );
                  },
                  label: const Text("Keluar"),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(1),
                    backgroundColor: const Color(0xFFFF0000),
                    foregroundColor: Colors.black,
                    textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(width: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CocokkanPage()),
                    );
                  },
                  label: const Text("Ya, Pilih Spesies"),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(1),
                    backgroundColor: const Color(0xFFB9F56A),
                    textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
