import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase=Supabase.instance.client;

  // REGISTER
  Future<String?> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {

      // CEK USERNAME SUDAH ADA ATAU BELUM
      final checkUsername=await supabase
          .from('profiles')
          .select()
          .eq('username',username)
          .maybeSingle();

      if(checkUsername!=null){
        return "Username sudah digunakan";
      }

      // REGISTER AUTH
      final response=await supabase.auth.signUp(
        email:email,
        password:password,
      );

      final user=response.user;

      if(user==null){
        return "Register gagal";
      }

      // INSERT PROFILE
      await supabase.from('profiles').insert({
        'id':user.id,
        'username':username,
        'email':email,
        'total_score':0,
      });

      return null;

    } on AuthException catch(e){
      return e.message;
    } catch(e){
      return e.toString();
    }
  }

  // LOGIN
  Future<String?> signIn({
    required String email,
    required String password,
  }) async {

    try {

      await supabase.auth.signInWithPassword(
        email:email,
        password:password,
      );

      return null;

    } on AuthException catch(e){
      return e.message;
    } catch(e){
      return e.toString();
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // GET USER
  User? getCurrentUser(){
    return supabase.auth.currentUser;
  }
}