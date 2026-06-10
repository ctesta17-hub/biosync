import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String label;
  final Color color;
  final String emoji;

  const CategoryCard({
    super.key,
    required this.label,
    required this.color,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Stack(children: [
        Positioned(
          right: -20,
          bottom: -20,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.18),
            ),
          ),
        ),
        Positioned(
          right: 18,
          top: 0,
          bottom: 0,
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 52)),
          ),
        ),
        Positioned(
          left: 20,
          top: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
