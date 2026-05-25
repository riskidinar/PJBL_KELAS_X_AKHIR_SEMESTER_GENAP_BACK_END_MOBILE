import 'package:flutter/material.dart';
import 'dart:math';
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
  
    // konfigurasi
    final int totalKartu = 9;
    final int targetBenar = 3;
    final int maxKesempatan = 6;

    // state
    late List<bool> kartuTerbuka;
    late List<bool> kartuBenar;

    int jumlahBenar = 0; // karena 1 ikan sudah terbuka 
    late int sisaKesempatan;

    @override
    void initState() {
      super.initState();
      sisaKesempatan = maxKesempatan;
      setupGame();
    }  

    // setup awal game
    void setupGame() {
      kartuTerbuka = List.generate(totalKartu, (_) => false);
      kartuBenar = List.generate(totalKartu, (_) => false);

      final random = Random();
      final indexAcak = <int>{};

      while (indexAcak.length < targetBenar) {
        indexAcak.add(random.nextInt(totalKartu));
      }

      // tandai kartu benar
      for (var i in indexAcak) {
        kartuBenar[i] = true;
      }

      // buka 1 kartu ikan dari awal
      final indexAwal = indexAcak.first;
      kartuTerbuka[indexAwal] = true;
    }

    // ketika kartu di klick
    void onKartuTap(int index){
      if (kartuTerbuka[index]) return;

      setState(() {
        kartuTerbuka[index] = true;

        if (kartuBenar[index]) {
          jumlahBenar++;

          if (jumlahBenar == targetBenar - 1) {
              // menang
              Future.delayed(const Duration(seconds: 0), () {  
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => WinPageMudah()),
              );
            });
           }
          } else {
            sisaKesempatan--;

            if (sisaKesempatan == 0) {
              // kalah
              Future.delayed(const Duration( seconds: 0), () {  
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LosePageMudah()),
              );
            });
            }
          }
      });
    }
  

  // UI / Tampilan
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBF3),
      body:SafeArea(
        child: Column(
        children: [
          
          const SizedBox(height: 5),

          Column (
            children: [
            // garis di atas quit
              Container(
                height: 3,
                width: double.infinity,
                color: Colors.black,
              ),

              const SizedBox(height: 15),

          // tombol quit
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: Image.asset(
              "img/icon_quit.png",
              height: 20,
            ),
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

          // garis di bawah quit
          Container(
            height: 3,
            width: double.infinity,
            color:  Colors.black,
          ),
        ],
      ),

              const SizedBox(height: 40),

              // kesempatan
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
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
                      // teks kiri kesempatan
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

                        // garis pemisah vertikal kesempatan
                        Container(
                          width: 2,
                          height: 55,
                          color: Colors.black,
                        ),

              // kotak angka kesempatan
              Container(
                width:  90,
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
                    fontFamily:  'Poppins',
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

         // grid kartu
         Expanded(
          child: Padding( 
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: GridView.builder(
            itemCount: totalKartu,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 9,
            crossAxisSpacing: 9
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => onKartuTap(index),
              child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7EB142),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xFF000000),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 6,
                    offset: Offset(0, 4)
                  ),
               ] 
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
                    fit: BoxFit.contain
                    ),
            ),
          ),
        );
      },
    ),
  ),
),

// soal
const SizedBox(height: 30),

// garis atas cari ikan
Container(
  height: 3,
  width: double.infinity,
  color: Colors.black,
),

const SizedBox(height: 15),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    // kotak + angka cari ikan
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius : BorderRadius.circular(5),
        border:  Border.all(
          color: Colors.black,
          width: 1, 
      ),
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
        // teks di kiri cari ikan
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Cari Gambar Di Atas",
              style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2),
          Text(
            "sebanyak...",
            style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            ),
          ),
        ],  
      ), 
    ),
        
        // garis pemisah cari ikan
        Container(
          width: 2,
          height: 65,
          color: Colors.black,
        ),

        // kotak angka 2 (terpisah, tapi menempel) cari ikan
        Container(
          width: 55,
          height: 55,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xFFFEF9F2),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
          ),
          child: const Text(
          "2",
          style: TextStyle(
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

    const SizedBox(width: 25),

    // gambar kotak ikan (tidak menempel)
    Container(
      width: 65,
      height:  65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: Color(0xFFFBEEC1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          "img/gambar_easy_page.png",
          width: double.infinity, 
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    ),
  ],
),

      const SizedBox(height: 15),
      
      // garis bawah cari ikan
      Container(
        height: 3,
        width: double.infinity,
        color: Colors.black,
      ),

          ],
        ),
      ),


      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 20), 
        child: Container(
            height: 70,
            decoration: const BoxDecoration(
              color: Color(0xFF3E7B27),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)
              ), 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // tombol setting
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SetingPage()
                    ),
                   );
                  },
                  child: Image.asset("img/icon_seting.png", width: 40),
                ),

                // tombol home
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (_) => HomePage()
                    ),
                   );
                  },
                  child: Image.asset("img/icon_homepage.png", width: 50),
                ),

                // tombol profil
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProfilPage()
                    ),
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
