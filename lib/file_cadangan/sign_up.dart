// import 'package:flutter/material.dart';
// import 'homepage.dart';
// // import 'sign_in.dart';
// import '../services/auth_service.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {

//   // CONTROLLER
//   final usernameController = TextEditingController();
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
//                 image: AssetImage("img/signin_and_signup.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // CONTENT
//           SafeArea(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [

//                   const SizedBox(height: 160),

//                   Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 24),
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
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // JUDUL
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Expanded(
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Sign up",
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 45,
//                                       fontWeight: FontWeight.w800,
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

//                         // USERNAME
//                         const Text(
//                           "Username",

//                           style: TextStyle(color: Colors.white, fontSize: 15),
//                         ),

//                         const SizedBox(height: 6),

//                         _inputBox(
//                           hint: "Username anda",
//                           controller: usernameController,
//                         ),

//                         const SizedBox(height: 12),

//                         // EMAIL
//                         const Text(
//                           "Email",

//                           style: TextStyle(color: Colors.white, fontSize: 15),
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

//                           style: TextStyle(color: Colors.white, fontSize: 15),
//                         ),

//                         const SizedBox(height: 6),

//                         _inputBox(
//                           hint: "Password",
//                           controller: passwordController,
//                           obscure: true,
//                         ),

//                         const SizedBox(height: 20),

//                         // BUTTON REGISTER
//                         Center(
//                           child: SizedBox(
//                             width: 150,
//                             height: 50,
//                             child: ElevatedButton(
//                               onPressed: () async {
//                                 final username = usernameController.text.trim();
//                                 final email = emailController.text.trim();
//                                 final password = passwordController.text.trim();

//                                 // VALIDASI USERNAME
//                                 if (username.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("Username wajib diisi"),
//                                     ),
//                                   );

//                                   return;
//                                 }
//                                 if (username.contains(' ')) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         "Username tidak boleh memakai spasi",
//                                       ),
//                                     ),
//                                   );

//                                   return;
//                                 }
//                                 if (username.length < 3) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         "Username minimal 3 karakter",
//                                       ),
//                                     ),
//                                   );
//                                   return;
//                                 }

//                                 // VALIDASI EMAIL
//                                 if (email.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("Email wajib diisi"),
//                                     ),
//                                   );

//                                   return;
//                                 }

//                                 // VALIDASI PASSWORD
//                                 if (password.length < 6) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         "Password minimal 6 karakter",
//                                       ),
//                                     ),
//                                   );

//                                   return;
//                                 }

//                                 // REGISTER
//                                 final error = await authService.signUp(
//                                   username: username,
//                                   email: email,
//                                   password: password,
//                                 );

//                                 // BERHASIL
//                                 if (error == null) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text("Register berhasil"),
//                                     ),
//                                   );
//                                   Navigator.pushReplacement(
//                                     context,

//                                     MaterialPageRoute(
//                                       builder: (_) => const HomePage(),
//                                     ),
//                                   );
//                                 }

//                                 // GAGAL
//                                 else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(content: Text(error)),
//                                   );
//                                 }
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFB9FF66),
//                               ),
//                               child: const Text(
//                                 "Let’s go!",

//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),

//                         // KE LOGIN
//                         // Center(
//                         //   child: GestureDetector(
//                         //     onTap: () {
//                         //       Navigator.push(
//                         //         context,
//                         //         MaterialPageRoute(
//                         //           builder: (_) =>
//                         //               const SignInPage(),
//                         //         ),
//                         //       );
//                         //     },
//                         //     child: const Text(
//                         //       "Belum punya akun? Daftar",
//                         //       style: TextStyle(
//                         //         color: Colors.white,
//                         //         fontSize: 18,
//                         //         fontWeight:
//                         //             FontWeight.w300,
//                         //         fontStyle:
//                         //             FontStyle.italic,
//                         //         decoration:
//                         //             TextDecoration.underline,
//                         //         decorationColor:
//                         //             Colors.white,
//                         //         decorationThickness: 2,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
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
//         border: Border.all(color: Colors.black, width: 2),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscure,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: const TextStyle(color: Colors.white),
//           border: InputBorder.none,
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 16,
//             vertical: 10,
//           ),
//         ),
//       ),
//     );
//   }
// }
