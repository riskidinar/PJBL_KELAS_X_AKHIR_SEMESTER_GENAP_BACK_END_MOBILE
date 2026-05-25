import 'package:flutter/material.dart';
import 'jelajahi_sekarang.dart';  // ganti dengan halaman tujuanmu
import 'input_field_profil.dart'; 

class ProfilPage extends StatelessWidget {
  const ProfilPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8DBA43),

      body: SafeArea(
        child: Column(
          children: [

            // ===== HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ===== FOTO PROFIL =====
            CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage("img/profile_online.png"),
            ),

            const SizedBox(height: 30),

            // ===== NAMA =====
            const Text(
              "Michael Willis",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // ===== TOMBOL EDIT =====
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF3E7B27),
                backgroundColor: Colors.white,
                side: const BorderSide(
                color: Colors.black,width: 2), // ubah ini untuk atur tebal border
                minimumSize: const Size(140, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Edit",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),

            

            // ===== CARD FORM =====
            Container(
              constraints: const BoxConstraints(minHeight: 300),
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                color: Colors.black,
                width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 9,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [

                  InputField(label: "Nama"),
                  const SizedBox(height: 15),
                  InputField(label: "Tentang"),
                  const SizedBox(height: 15),
                  InputField(label: "Email"),

                ],
              ),
            ),

            const Spacer(),

            // ===== LOGOUT =====
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => JelajahiSekarang(), // tujuan logout
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "img/icon_logout.png",
                      width: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Sign out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}