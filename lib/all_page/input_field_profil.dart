import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;

  const InputField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // ===== LABEL TEXT =====
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // ===== KOTAK INPUT =====
        Container(
          height: 40,
          alignment: Alignment.center, // 🔥 ATUR TINGGI DI SINI
          padding: const EdgeInsets.symmetric(horizontal: 10), 
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),

            // 🔥 BORDER TEBAL
            border: Border.all(
              color: Colors.black,
              width: 2, // 🔥 atur ketebalan di sini
            ),

            // 🔥 SHADOW
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const TextField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
          border: InputBorder.none,
          isCollapsed: true,
            ),
          ),
        ),
      ],
    );
  }
}