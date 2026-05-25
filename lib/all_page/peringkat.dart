import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: PapanPeringkatPage()),
  );
}

class PapanPeringkatPage extends StatelessWidget {
  const PapanPeringkatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final players = [
      Player("Kathryn Murphy", 67, "img/gambar1_leaderboard.png"),
      Player("Henry Legolas", 56, "img/gambar2_leaderboard.png"),
      Player("Stepford Johanson", 31, "img/gambar3_leaderboard.png"),
      Player("Rem Leyte", 26, "img/gambar4_leaderboard.png"),
      Player("Stephen Hawking", 17, "img/gambar5_leaderboard.png"),
      Player("Cameron Williamson", 15, "img/gambar6_leaderboard.png"),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF7EB142),
        leading: BackButton(
            color: Color(0xFFFFFFFF),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        title: Text(
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
            // list scroll
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: players.length,
                itemBuilder: (context, index) {
                  final p = players[index];

                  return PapanPeringkatItem(
                    rank: index + 1,
                    nama: p.nama,
                    skor: p.skor,
                    image: p.image,
                  );
                },
              ),
            ),

            
          ],
        ),
      ),

      bottomNavigationBar: Container(
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
            color: Color(0xFFFBEEC1),
            borderRadius: BorderRadius.circular(15),
              ),
                child: PapanPeringkatItem(
                rank: 1,
                nama: "Kathryn Murphy",
                skor: 67,
                image: 'img/gambar1_leaderboard.png',
              ),
        ),
      ),
    );
  }
}

class Player {
  final String nama;
  final int skor;
  final String image;

  Player(this.nama, this.skor, this.image);
}

class PapanPeringkatItem extends StatelessWidget {
  final int rank;
  final String nama;
  final int skor;
  final String image;

  const PapanPeringkatItem({
    super.key,
    required this.rank,
    required this.nama,
    required this.skor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 70,
      decoration: BoxDecoration(
        color: rank == 1 ? const Color(0xFFFBEEC1) : const Color(0xFF7EB142),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Text('$rank', style: TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(width: 15),

          CircleAvatar(backgroundImage: AssetImage(image)),

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