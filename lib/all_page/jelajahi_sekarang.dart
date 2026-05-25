import 'package:flutter/material.dart';
import 'sign_in.dart';


class JelajahiSekarang extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF9F2),
      body: SafeArea(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height:  20),
            Transform.translate(
            offset: Offset(0, -40),
            child: Image.asset("img/logo_wallacea_hitam.png",
              width: 250,
              height: 300,
            ),
            ),
            
            Transform.translate(
            offset: Offset(0, -140),
            child: Image.asset("img/gambar_in_jelajahi.png",
              width: 400,
              height: 400,
            ),
            ),

            Transform.translate(
            offset: Offset(0, -170),
            child: 
            const Text("Mainkan Game",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500,)),),
            Transform.translate(
            offset: Offset(0, -170),
            child: 
            const Text("Puzzle kami",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500,)),),
            Transform.translate(
            offset: Offset(0, -170),
            child: 
            const Text("Sekarang !",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500,)),),
            
             Transform.translate(
                  offset: Offset(0, -140),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7EB142),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Mainkan Sekarang!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          ],
        ),
       ), 
      ),
    );
  }
}
