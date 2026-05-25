import 'package:flutter/material.dart';
import 'jelajahi_sekarang.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() =>  _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _pindahHalaman();
  }

  void _pindahHalaman() {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (Context) => JelajahiSekarang()),
      );
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xFF7EB142),
    body: Center(
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Image.asset("img/logo_wallacea_putih.png",
          width: 250,
          height: 300,
          ),
          SizedBox(height: 20),
          CircularProgressIndicator(color: Colors.white),
        ],
      ),
    ),
  );
  

}
}


