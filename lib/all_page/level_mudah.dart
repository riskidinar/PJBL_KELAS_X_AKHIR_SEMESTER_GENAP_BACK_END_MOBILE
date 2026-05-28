import 'package:flutter/material.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'win_mudah_page.dart';
import 'lose_mudah_page.dart';
import 'setting.dart';
import 'homepage.dart';
import 'profil.dart';

class LevelMudahPage extends StatefulWidget {
  const LevelMudahPage({super.key});

  @override
  State<LevelMudahPage> createState() => _LevelMudahPageState();
}

class _LevelMudahPageState extends State<LevelMudahPage> {
  // KONFIGURASI GAME
  final int totalKartu = 9;
  final int targetBenar = 3;
  final int maxKesempatan = 6;

  // STATE GAME
  late List<bool> kartuTerbuka;
  late List<bool> kartuBenar;

  int jumlahBenar = 0;
  late int sisaKesempatan;

  // TIMER
  late DateTime waktuMulai;

  // SUPABASE
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();

    sisaKesempatan = maxKesempatan;

    // mulai hitung waktu
    waktuMulai = DateTime.now();

    setupGame();
  }

  // SETUP GAME
  void setupGame() {
    kartuTerbuka = List.generate(totalKartu, (_) => false);

    kartuBenar = List.generate(totalKartu, (_) => false);

    final random = Random();
    final indexAcak = <int>{};
    while (indexAcak.length < targetBenar) {
      indexAcak.add(random.nextInt(totalKartu));
    }

    // kartu benar
    for (var i in indexAcak) {
      kartuBenar[i] = true;
    }

    // buka 1 kartu otomatis
    final indexAwal = indexAcak.first;

    kartuTerbuka[indexAwal] = true;
  }

  // HITUNG SKOR MENANG
  int hitungSkorMenang() {
    final durasi = DateTime.now().difference(waktuMulai);

    final detik = durasi.inSeconds;

    // semakin cepat semakin besar

    if (detik <= 5) {
      return 100;
    } else if (detik <= 10) {
      return 80;
    } else if (detik <= 15) {
      return 60;
    } else if (detik <= 20) {
      return 40;
    } else {
      return 20;
    }
  }

  // HITUNG SKOR KALAH
  int hitungSkorKalah() {
    final random = Random();

    // random 6 - 9
    return 6 + random.nextInt(4);
  }

  // SIMPAN SKOR KE DATABASE
  Future<void> simpanSkor(int skorBaru) async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) return;

      // ambil total skor lama
      final data = await supabase
          .from('profiles')
          .select('total_score')
          .eq('id', user.id)
          .single();

      final totalLama = data['total_score'] ?? 0;
      final totalBaru = totalLama + skorBaru;

      // update total score
      await supabase
          .from('profiles')
          .update({
            'total_score': totalBaru,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', user.id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // KETIKA KARTU DI KLIK
  void onKartuTap(int index) {
    if (kartuTerbuka[index]) return;

    setState(() {
      kartuTerbuka[index] = true;

      // JIKA BENAR
      if (kartuBenar[index]) {
        jumlahBenar++;

        // MENANG
        if (jumlahBenar == targetBenar - 1) {
          final skor = hitungSkorMenang();

          simpanSkor(skor);

          Future.delayed(const Duration(seconds: 0), () {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(builder: (_) => WinPageMudah(skor: skor)),
            );
          });
        }
      }
      // JIKA SALAH
      else {
        sisaKesempatan--;

        // KALAH
        if (sisaKesempatan == 0) {
          final skor = hitungSkorKalah();

          simpanSkor(skor);

          Future.delayed(const Duration(seconds: 0), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => LosePageMudah(skor: skor)),
            );
          });
        }
      }
    });
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 5),
            Column(
              children: [
                // GARIS ATAS
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.black,
                ),

                const SizedBox(height: 15),

                // BUTTON QUIT
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Image.asset("img/icon_quit.png", height: 20),
                  label: const Text(
                    "Quit",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB9FF66),
                    elevation: 3,
                    shadowColor: Colors.black.withOpacity(0.9),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // GARIS BAWAH
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // KESEMPATAN
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: const Text(
                      "Kesempatan memilih tersisa...",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Container(width: 2, height: 55, color: Colors.black),
                  Container(
                    width: 90,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFEF9F2),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "$sisaKesempatan",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFF0000),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: GridView.builder(
                  itemCount: totalKartu,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 9,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onKartuTap(index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF7EB142),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF000000),

                            width: 2,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Center(
                          child: kartuTerbuka[index]
                              ? (kartuBenar[index]
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          "img/gambar_easy_page.png",
                                          width: double.infinity,
                                          height: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        "img/icon_silang.png",
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ))
                              : Image.asset(
                                  "img/icon_tanda_tanya.png",

                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // ================= SOAL =================
            Container(height: 3, width: double.infinity, color: Colors.black),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Cari Gambar Di Atas",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "sebanyak...",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 2, height: 65, color: Colors.black),
                      const SizedBox(
                        width: 55,
                        height: 55,
                        child: Center(
                          child: Text(
                            "4",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 25),
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFFBEEC1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    "img/gambar_easy_page.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(height: 3, width: double.infinity, color: Colors.black),
            const SizedBox(height: 15),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Color(0xFF3E7B27),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // SETTING
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => SetingPage()),
                  );
                },

                child: Image.asset("img/icon_seting.png", width: 40),
              ),

              // HOME
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
                child: Image.asset("img/icon_homepage.png", width: 50),
              ),

              // PROFIL
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilPage()),
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
}
