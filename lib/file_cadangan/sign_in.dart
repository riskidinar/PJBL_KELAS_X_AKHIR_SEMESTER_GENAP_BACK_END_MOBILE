// import 'package:flutter/material.dart';
// import 'package:pjbl_backend_mobile_akhirsemestergenap_kelas_x/all_page/guest_mode.dart';
// import 'homepage.dart';
// import 'sign_up.dart';
// import '../services/auth_service.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {

//   // CONTROLLER INPUT
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   // AUTH SERVICE
//   final authService = AuthService();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [

//           // BACKGROUND
//           Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(
//                   "img/signin_and_signup.png",
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // KONTEN
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [

//                   const SizedBox(height: 120),

//                   // CARD LOGIN
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                     ),
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF7EB142),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.25),
//                           blurRadius: 6,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),

//                     child: Column(
//                       crossAxisAlignment:
//                           CrossAxisAlignment.start,
//                       children: [

//                         // JUDUL + LOGO
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),

//                           child: Row(
//                             mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,

//                             children: [
//                               const Expanded(
//                                 child: Align(
//                                   alignment:
//                                       Alignment.centerLeft,
//                                   child: Text(
//                                     "Sign in",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 45,
//                                       fontWeight:
//                                           FontWeight.w800,
//                                     ),
//                                   ),
//                                 ),
//                               ),

//                               Image.asset(
//                                 "img/logo_wallacea_putih.png",
//                                 width: 95,
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 10),

//                         // EMAIL

//                         const Text(
//                           "Email",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             shadows: [
//                               Shadow(
//                                 offset: Offset(2, 2),
//                                 blurRadius: 4,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 6),

//                         _inputBox(
//                           hint: "Email anda",
//                           controller: emailController,
//                         ),

//                         const SizedBox(height: 12),

//                         // PASSWORD
//                         const Text(
//                           "Password",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             shadows: [
//                               Shadow(
//                                 offset: Offset(2, 2),
//                                 blurRadius: 4,
//                                 color: Colors.black,
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 6),

//                         _inputBox(
//                           hint: "Password",
//                           controller: passwordController,
//                           obscure: true,
//                         ),

//                         const SizedBox(height: 20),

//                         // BUTTON LOGIN
//                         Center(
//                           child: SizedBox(
//                             width: 150,
//                             height: 50,
//                             child: ElevatedButton(
//                               onPressed: () async {

//                                 // LOGIN KE SUPABASE
//                                 final error =
//                                     await authService.signIn(
//                                   email:
//                                       emailController.text,
//                                   password:
//                                       passwordController.text,
//                                 );

//                                 // JIKA BERHASIL
//                                 if (error == null) {
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         "Login berhasil",
//                                       ),
//                                     ),
//                                   );

//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (_) =>
//                                           const HomePage(),
//                                     ),
//                                   );

//                                 }

//                                 // JIKA GAGAL 

//                                 else {

//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(
//                                     SnackBar(
//                                       content:
//                                           Text(error),
//                                     ),
//                                   );
//                                 }
//                               },

//                               style:
//                                   ElevatedButton.styleFrom(
//                                 backgroundColor:
//                                     const Color(0xFFB9FF66),
//                                 shape:
//                                     const RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.only(
//                                     topLeft:
//                                         Radius.circular(18),
//                                     topRight:
//                                         Radius.circular(20),
//                                     bottomLeft:
//                                         Radius.circular(20),
//                                     bottomRight:
//                                         Radius.circular(18),
//                                   ),
//                                 ),
//                               ),

//                               child: const Text(
//                                 "Let’s go!",
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 16,
//                                   fontWeight:
//                                       FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 19),

//                         // KE HALAMAN REGISTER

//                         Center(
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       const SignUpPage(),
//                                 ),
//                               );
//                             },
//                             child: const Text(
//                               "Belum punya akun? Daftar",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18,
//                                 fontWeight:
//                                     FontWeight.w300,
//                                 fontStyle:
//                                     FontStyle.italic,
//                                 decoration:
//                                     TextDecoration.underline,
//                                 decorationColor:
//                                     Colors.white,
//                                 decorationThickness: 2,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 30),

//                   // GUEST MODE
//                   Container(
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                     ),
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF8DBA43),
//                       borderRadius:
//                           BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color:
//                               Colors.black.withOpacity(0.25),
//                           blurRadius: 6,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         const Text(
//                           "ATAU",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),

//                         const SizedBox(height: 12),

//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton.icon(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       const GuestMode(),
//                                 ),
//                               );
//                             },
//                             icon: Padding(
//                               padding:
//                                   const EdgeInsets.only(
//                                 right: 8,
//                               ),
//                               child: Image.asset(
//                                 "img/icon_profil.png",
//                                 width: 28,
//                               ),
//                             ),
//                             label: const Text(
//                               "Lanjutkan dengan Guest Mode",
//                             ),
//                             style:
//                                 ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   const Color(0xFFB9FF66),
//                               foregroundColor:
//                                   Colors.black,
//                               shape:
//                                   RoundedRectangleBorder(
//                                 borderRadius:
//                                   BorderRadius.circular(15),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // INPUT BOX
//   Widget _inputBox({
//     required String hint,
//     required TextEditingController controller,
//     bool obscure = false,
//   }) {

//     return Container(
//       width: 330,
//       height: 45,
//       decoration: BoxDecoration(
//         color: const Color(0xFF7EB142),
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: Colors.black,
//           width: 2,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.3),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         textAlignVertical:
//             TextAlignVertical.center,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle:
//               const TextStyle(color: Colors.white),
//           border: InputBorder.none,
//           contentPadding:
//               const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 10,
//           ),
//         ),
//       ),
//     );
//   }
// }