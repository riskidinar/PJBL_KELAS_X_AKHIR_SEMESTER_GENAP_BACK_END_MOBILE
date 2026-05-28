import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final supabase = Supabase.instance.client;

  // AMBIL DATA PROFILE
  Future<Map<String,dynamic>?> getProfile() async {
    try {
      final user = supabase.auth.currentUser;

      if(user == null) return null;

      final data = await supabase
          .from('profiles')
          .select()
          .eq('id',user.id)
          .single();

      return data;
    } catch (e) {
      return null;
    }
  }

  // PILIH FOTO
  Future<File?> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if(image == null) return null;

    return File(image.path);
  }

  // UPLOAD FOTO
  Future<String?> uploadAvatar(File file) async {
    try {
      final user = supabase.auth.currentUser;

      if(user == null) return null;

      final fileName = '${user.id}.jpg';

      await supabase.storage
          .from('avatars')
          .upload(
            fileName,
            file,
            fileOptions: const FileOptions(
              upsert: true,
            ),
          );

      final imageUrl = supabase.storage
          .from('avatars')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      return null;
    }
  }

  // UPDATE PROFILE
  Future<String?> updateProfile({
    required String username,
    required String about,
    String? avatarUrl,
  }) async {
    try {
      final user = supabase.auth.currentUser;

      if(user == null) {
        return "User tidak ditemukan";
      }

      // CEK USERNAME SUDAH ADA ATAU BELUM
      final usernameCheck = await supabase
          .from('profiles')
          .select()
          .neq('id',user.id)
          .ilike('username',username);

      if(usernameCheck.isNotEmpty) {
        return "Username sudah digunakan";
      }

      // UPDATE DATA
      await supabase
          .from('profiles')
          .update({
            'username': username,
            'about': about,
            'avatar_url': avatarUrl,
          })
          .eq('id',user.id);

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}