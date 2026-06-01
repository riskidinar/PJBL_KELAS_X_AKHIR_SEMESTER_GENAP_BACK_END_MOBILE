import 'package:flutter/material.dart';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'win_sangat_sulit_page.dart';
import 'lose_sangat_sulit_page.dart';
import 'setting.dart';
import 'homepage.dart';
import 'profil.dart';

class LevelSangatSulitPage extends StatefulWidget {
  const LevelSangatSulitPage({super.key});

  @override
  State<LevelSangatSulitPage> createState() => _LevelSangatSulitPageState();
}

class _LevelSangatSulitPageState extends State<LevelSangatSulitPage> {

  // ================= KONFIGURASI =================
  final int totalKartu = 17;
  final int targetBenar = 9;
  final int maxKesempatan = 3;

  // ================= STATE =================
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

              MaterialPageRoute(builder: (_) => WinSangatSulitPage (skor: skor)),
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
              MaterialPageRoute(builder: (_) => LoseSangatSulitPage (skor: skor)),
            );
          });
        }
      }
    });
  }

  // ================= WIDGET KARTU =================
  Widget kartu(int index) {
    return GestureDetector(
      onTap: () => onKartuTap(index),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: const Color(0xFF7EB142),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 2),
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
                        "img/gambar_sangat_sulit_page.png",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      "img/icon_silang.png",
                      width: 40,
                    ))
              : Image.asset(
                  "img/icon_tanda_tanya.png",
                  width: 25,
                ),
        ),
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF3),
      body: SafeArea(
        child: Column(
          children: [

            // ================= QUIT =================
            Container(height: 3, width: double.infinity, color: Colors.black),
            const SizedBox(height: 15),

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
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 15),
            Container(height: 3, width: double.infinity, color: Colors.black),

            const SizedBox(height: 40),

            // ================= KESEMPATAN =================
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Kesempatan memilih tersisa...",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(width: 2, height: 55, color: Colors.black),
                  Container(
                    width: 90,
                    height: 55,
                    alignment: Alignment.center,
                    child: Text(
                      "$sisaKesempatan",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),

            // ================= KARTU (SILANG) =================
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kartu(0),
                      const SizedBox(width: 8),
                      kartu(1),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kartu(2),
                      const SizedBox(width: 8),
                      kartu(3),
                      const SizedBox(width: 8),
                      kartu(4),
                      const SizedBox(width: 8),
                      kartu(5),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 5
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kartu(6),
                      const SizedBox(width: 8),
                      kartu(7),
                      const SizedBox(width: 8),
                      kartu(8),
                      const SizedBox(width: 8),
                      kartu(9),
                      const SizedBox(width: 8),
                      kartu(10),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kartu(11),
                      const SizedBox(width: 8),
                      kartu(12),
                      const SizedBox(width: 8),
                      kartu(13),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      kartu(14),
                      const SizedBox(width: 8),
                      kartu(15),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 1 (fokus)
                  kartu(16),
                ],
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          children: [
                            Text("Cari Gambar Di Atas",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600)),
                            Text("sebanyak...",
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      Container(width: 2, height: 65, color: Colors.black),
                      const SizedBox(
                        width: 55,
                        height: 55,
                        child: Center(
                          child: Text(
                            "8",
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
                    "img/gambar_sangat_sulit_page.png",
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

      // ================= BOTTOM NAV =================
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF3E7B27),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => SetingPage())),
              child: Image.asset("img/icon_seting.png", width: 40),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage())),
              child: Image.asset("img/icon_homepage.png", width: 50),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ProfilPage())),
              child: Image.asset("img/icon_profil.png", width: 40),
            ),
          ],
        ),
      ),
    );
  }
}