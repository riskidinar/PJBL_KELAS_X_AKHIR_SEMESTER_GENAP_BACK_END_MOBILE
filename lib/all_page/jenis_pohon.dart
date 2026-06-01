import 'dart:async';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'selesai_mencocokkan.dart'; 
import 'setting.dart';
import 'homepage.dart';
import 'profil.dart';

class MencocokkanPohonPage extends StatefulWidget {
  const MencocokkanPohonPage({super.key});

  @override
  State<MencocokkanPohonPage> createState() => _MencocokkanPohonPageState();
}

class _MencocokkanPohonPageState extends State<MencocokkanPohonPage> {

  // stopwatch
  late Stopwatch stopwatch;

  final List<String> correctOrder = ["Angsana", "Merbau", "Kenari"];
  late List<String> draggableItems;

  Map<String, String?> placed = {};
  String? wrongTarget;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
    stopwatch.start();
    startGame();
  }

  void startGame() {
    draggableItems = List.from(correctOrder);
    draggableItems.shuffle(Random());
    placed = {"Angsana": null, "Merbau": null, "Kenari": null};
    wrongTarget = null;
  }

  bool isFinished() {
    return placed.values.every((e) => e != null);
  }

  void checkFinish() { 
    if (isFinished()) {
      stopwatch.stop();
      int finalScore = calculateScore();
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => GameSelesaiPage(score: finalScore,)),
        );
      });
    }
  }

  void showWrongEffect(String targetName) {
    setState(() {
      wrongTarget = targetName;
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        wrongTarget = null;
      });
    });
  }

  int calculateScore() {
    final seconds = stopwatch.elapsed.inSeconds;

    if (seconds <= 10) {
      return 100;
    } else if (seconds <= 20) {
      return 80;
    } else if (seconds <= 30) {
      return 60;
    } else {
      return 40;
    }
  }

  final supabase = Supabase.instance.client;

  Future<void> saveScore(int score) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      // ambil skor lama
      final data = await supabase
          .from('profiles')
          .select('total_score')
          .eq('id', user.id)
          .single();
      int currentScore = data['total_score'] ?? 0;

      // update skor baru
      await supabase
          .from('profiles')
          .update({'total_score': currentScore + score})
          .eq('id', user.id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1,
        toolbarHeight: 50,
        backgroundColor: Colors.white,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                // garis di atas quit
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.black,
                ),

                const SizedBox(height: 25),

                // tombol quit
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

                const SizedBox(height: 25),

                // garis di bawah quit
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ],
            ),

            // ===== GAMBAR =====
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        "img/g1_pohon.png",
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Expanded(
                      child: Image.asset(
                        "img/g2_pohon.png",
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Expanded(
                      child: Image.asset(
                        "img/g3_pohon.png",
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                // garis di bawah gambar
                Container(
                  height: 3,
                  width: double.infinity,
                  color: Colors.black,
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ===== TARGET BOX =====
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: correctOrder.map((targetName) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18, // jarak antar kotak
                  ),

                  child: DragTarget<String>(
                    onAccept: (data) {
                      if (data == targetName) {
                        setState(() {
                          placed[targetName] = data;
                          draggableItems.remove(data);
                        });

                        checkFinish(); 
                      } else {
                        showWrongEffect(targetName);
                      }
                    },

                    builder: (context, candidateData, rejectedData) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),

                        width: 95, // lebar kotak
                        height: 35, // tinggi kotak

                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: wrongTarget == targetName
                              ? Colors.red
                              : const Color(0xFFD9D9D9),

                          borderRadius: BorderRadius.circular(4),

                          border: Border.all(color: Colors.black26),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),

                        child: Text(
                          placed[targetName] ??
                              "Pilih Jawabanmu", // tulisan default
                          style: const TextStyle(
                            fontSize: 8,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 80),

            // ===== TEXT =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),

              child: Text(
                "Cocokan tulisan Di bawah ini\n"
                "Berdasarkan gambar di atas dengan\n"
                "cara di Drag ke kotak yang telah\n"
                "disediakan.",

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 80),

            // ===== DRAG AREA =====
            Container(
              width: 340,
              height: 130,
              decoration: BoxDecoration(
                color: Color(0xFFFEF9F2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: draggableItems.map((name) {
                  return Draggable<String>(
                    data: name,

                    feedback: Material(
                      color: Colors.transparent,

                      child: Container(
                        width: 95,
                        height: 35,

                        alignment: Alignment.center,

                        decoration: BoxDecoration(
                          color: const Color(0xFF8DBB45),

                          borderRadius: BorderRadius.circular(4),
                        ),

                        child: Text(
                          name,

                          style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    childWhenDragging: const SizedBox(width: 90, height: 150),

                    child: Container(
                      width: 95,
                      height: 35,

                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: const Color(0xFF8DBB45),

                        borderRadius: BorderRadius.circular(4),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),

                      child: Text(
                        name,

                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Spacer(),
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
              // tombol setting
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SetingPage()),
                  );
                },
                child: Image.asset("img/icon_seting.png", width: 40),
              ),

              // tombol home
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
                child: Image.asset("img/icon_homepage.png", width: 50),
              ),

              // tombol profil
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
