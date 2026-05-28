import 'package:supabase_flutter/supabase_flutter.dart';

class ScoreService {
  final supabase = Supabase.instance.client;
  Future<void> tambahScore(int score) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    final data = await supabase
        .from('profiles')
        .select('total_score')
        .eq('id', user.id)
        .single();

    final currentScore = data['total_score'] ?? 0;
    final newScore = currentScore + score;

    await supabase
        .from('profiles')
        .update({
          'total_score': newScore,
          'updated_at': DateTime.now().toIso8601String(),
        })
        .eq('id', user.id);
  }
}
