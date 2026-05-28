import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'jelajahi_sekarang.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final supabase = Supabase.instance.client;

  final usernameController = TextEditingController();
  final aboutController = TextEditingController();
  final emailController = TextEditingController();

  File? imageFile;
  String? avatarUrl;
  int totalScore = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  // AMBIL DATA PROFILE
  Future<void> getProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;
      final data = await supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      usernameController.text = data['username'] ?? "";
      aboutController.text = data['about'] ?? "";
      emailController.text = data['email'] ?? "";
      avatarUrl = data['avatar_url'];
      totalScore = data['total_score'] ?? 0;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // PILIH FOTO
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // UPLOAD FOTO KE STORAGE
  Future<String?> uploadImage() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null || imageFile == null) return null;
      final fileName = "${DateTime.now().millisecondsSinceEpoch}.png";
      await supabase.storage.from('avatars').upload(fileName, imageFile!);
      final imageUrl = supabase.storage.from('avatars').getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // SAVE PROFILE
  Future<void> saveProfile() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;
      final usernameBaru = usernameController.text.trim();

      // CEK USERNAME SUDAH ADA ATAU BELUM
      final checkUsername = await supabase.rpc(
        'check_username_exists',
        params: {'username_input': usernameBaru},
      );

      // AMBIL USERNAME LAMA
      final currentData = await supabase
          .from('profiles')
          .select('username')
          .eq('id', user.id)
          .single();

      final usernameLama = currentData['username'];

      // JIKA USERNAME SUDAH DIPAKAI USER LAIN
      if (checkUsername == true &&
          usernameBaru.toLowerCase() != usernameLama.toLowerCase()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username sudah digunakan")),
        );

        return;
      }

      String? imageUrl = avatarUrl;

      // JIKA ADA FOTO BARU
      if (imageFile != null) {
        imageUrl = await uploadImage();
      }

      // UPDATE DATABASE
      await supabase
          .from('profiles')
          .update({
            'username': usernameBaru,
            'about': aboutController.text.trim(),
            'avatar_url': imageUrl,
          })
          .eq('id', user.id);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile berhasil diupdate")),
      );

      getProfile();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await supabase.auth.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => JelajahiSekarang()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF8DBA43),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            
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

            // FOTO PROFIL
            GestureDetector(
              onTap: pickImage,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: imageFile != null
                    ? FileImage(imageFile!)
                    : avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : const AssetImage("img/profile_online.png")
                          as ImageProvider,
              ),
            ),

            const SizedBox(height: 15),

            // BUTTON EDIT
            OutlinedButton(
              onPressed: saveProfile,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF3E7B27),
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.black, width: 1),
                minimumSize: const Size(125, 38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),

              child: const Text(
                "Edit",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
              ),
            ),

            // CARD FORM
            Container(
              constraints: const BoxConstraints(minHeight: 290),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFBEEC1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const SizedBox(height: 10),

                  const Padding(
                    padding: EdgeInsets.only(left: 12),

                    child: Text(
                      "Username",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  inputBox(controller: usernameController),

                  const SizedBox(height: 15),

                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  inputBox(controller: aboutController),

                  const SizedBox(height: 15),

                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  inputBox(controller: emailController, enabled: false),
                ],
              ),
            ),

            // TOTAL SCORE
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: const Color(0xFFFBEEC1),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 9,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    "Total Skor Minggu ini",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: 280,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black, width: 2),
                    ),

                    child: Center(
                      child: Text(
                        "$totalScore",
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // LOGOUT
            GestureDetector(
              onTap: signOut,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("img/icon_logout.png", width: 20),
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

  // INPUT BOX
  Widget inputBox({
    required TextEditingController controller,
    bool enabled = true,
  }) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEEC1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
