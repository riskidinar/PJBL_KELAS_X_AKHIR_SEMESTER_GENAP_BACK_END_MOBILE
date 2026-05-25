import 'package:flutter/material.dart';

void main() {
  runApp(const TentangKamiPage());
}

class TentangKamiPage extends StatelessWidget {
  const TentangKamiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      title: "tentang kami",
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color(0xFF7EB142),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('img/icon_about.png', height: 30, color: Color(0xFFFFFFFF),),
              SizedBox(width: 15),
              Center(
                child: Text(
                  "Tentang Kami",
                  style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF)),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kami membut game berbasis menyususun menebak susunan puzzle / gambar dan mencocokkan nama umum flora / fauna berdasarkan pada gambar yang sudah kami buat. Game ini di buat oleh : Riski DNR & FaruqSoNice. Game ini di buat untuk menghibur pengguna beserta sekaligus memberikan informasi tentang flora / fauna tersebut kepada pengguna aplikasi.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Game ini di buat berdasarkan pengamatan kami. Seperti game pada umumnya, jenis game kami seperti menebak posisi kartu yang benar di anatara kartu lain yang salah / zonk dengan level kesulitan yang berbeda beda. selain itu kami juga meyediakan jenis game yang lain nya juga yaitu mencocokkan gambar flora fauna tersebut pada nama umumnya dengan cara menekan dan menarik nama umumnya pada kolom jawaban yang sudah di sediakan.",
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Harapan kami pada game mobile ini adalah dapat mengedukasi orang banyak sehingga membuat orang yang memainkan game kami mendapat hiburan beserta informasi yang bermanfaat dari game yang kami buat. ",
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 65,
              color: const Color.fromARGB(255, 126, 177, 66),
            ),
          ],
        ),
      ),
    );
  }
}