import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PapanPeringkatPage extends StatefulWidget {
  const PapanPeringkatPage({super.key});

  @override
  State<PapanPeringkatPage> createState() => _PapanPeringkatPageState();
}

class _PapanPeringkatPageState extends State<PapanPeringkatPage> {
  final supabase = Supabase.instance.client;

  List players = [];
  Map<String, dynamic>? currentUserData;
  int currentUserRank = 0;
  @override
  void initState() {
    super.initState();
    ambilLeaderboard();
  }
  Future<void> ambilLeaderboard() async {
    final data = await supabase
        .from('profiles')
        .select()
        .order('total_score', ascending: false);

    setState(() {
      players = data;
    });
    final user = supabase.auth.currentUser;
    if (user != null) {
      final index = players.indexWhere((item) => item['id'] == user.id);
      if (index != -1) {
        currentUserRank = index + 1;

        currentUserData = players[index];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF7EB142),
        leading: BackButton(
          color: const Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Papan Peringkat',
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('img/background_leaderboard.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final p = players[index];

                  return PapanPeringkatItem(
                    rank: index + 1,
                    nama: p['username'] ?? '-',
                    skor: p['total_score'] ?? 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: currentUserData == null
          ? null
          : Container(
              height: 120,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF0A400C),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBEEC1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: PapanPeringkatItem(
                  rank: currentUserRank,
                  nama: currentUserData!['username'],
                  skor: currentUserData!['total_score'],
                ),
              ),
            ),
    );
  }
}

class PapanPeringkatItem extends StatelessWidget {
  final int rank;
  final String nama;
  final int skor;

  const PapanPeringkatItem({
    super.key,
    required this.rank,
    required this.nama,
    required this.skor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 70,
      decoration: BoxDecoration(
        color: rank == 1 ? const Color(0xFFFBEEC1) : const Color(0xFF7EB142),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text('$rank', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 15),
          const CircleAvatar(
            backgroundImage: AssetImage('img/default_profile.png'),
          ),
          const SizedBox(width: 25),
          Expanded(child: Text(nama, style: textTheme.bodyMedium)),
          Text('$skor', style: textTheme.titleMedium),
          const SizedBox(width: 8),
          Image.asset('img/icon_mendali_hitam.png', width: 20),
        ],
      ),
    );
  }
}
