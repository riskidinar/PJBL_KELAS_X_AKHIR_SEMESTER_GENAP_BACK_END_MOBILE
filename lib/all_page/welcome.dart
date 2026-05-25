// import 'package:flutter/material.dart';
// import 'signin_or_signup.dart';

// // import dari tombol sebelumnya
// class welcome extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
          

//           // background full
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("img/welcome.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

          
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
                
//                 Image.asset(
//                   "img/logo_wallacea_hitam.png",
//                   width: 250,
//                   height: 300, 
//                 ),

//                 tombol interaktif
//                 Transform.translate(
//                   offset: Offset(0, -40),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => signin_or_signup(),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF7EB142),
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 8,
//                       ),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     child: Text(
//                       "Jelajahi Sekarang !",
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
