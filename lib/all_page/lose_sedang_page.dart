import 'package:flutter/material.dart';
import 'level_sedang.dart';

class LosePageSedang extends StatelessWidget {

  final int skor;
  const LosePageSedang({
    super.key,
    required this.skor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7EB142),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // box Teks
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 115,
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
                "kamu Kalah !",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),

            const SizedBox(height: 25),

            // Box Score
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
                  const SizedBox(height: 5),
                  const Text(
                    "Total Skor Level ini",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$skor",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 22),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // all tombol
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset("img/icon_quit.png", width: 18, height: 18),
                  label: const Text("Quit"),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(1),
                    backgroundColor: const Color(0xFFB9F56A),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const LevelSedangPage()),
                    );
                  },
                  icon: Image.asset(
                    "img/icon_reset.png",
                    width: 18,
                    height: 18,
                  ),
                  label: const Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(1),
                    backgroundColor: const Color(0xFFB9F56A),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(width: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
