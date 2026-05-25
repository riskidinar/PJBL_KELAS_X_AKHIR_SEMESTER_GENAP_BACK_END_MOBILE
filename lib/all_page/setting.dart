import 'package:flutter/material.dart';
import 'about_us.dart';
import 'homepage.dart';
import 'profil.dart';
import 'peringkat.dart';


void main() {
  runApp( SetingPage());
}

class SetingPage extends StatelessWidget {
  const SetingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF7EB142),
          leading: BackButton(color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 15),
              Center(
                child: Text(
                  'Pengaturan',
                  style: TextStyle(fontSize: 30, color: Color(0xFFFFFFFF), fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PapanPeringkatPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7EB142),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/icon_peringkat.png',
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Papan Peringkat',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: double.infinity,
                height: 65,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TentangKamiPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7EB142),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'img/icon_about.png',
                        color: Color(0xFFFFFFFF),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Tentang Kami',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
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
      ),
    );
  }
}