import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../breathing/breathing_screen.dart';

class AlertCard extends StatelessWidget {
  final VoidCallback onDismiss;

  const AlertCard({super.key, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              '⚠️  Pausa consigliata',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.45,
                fontFamily: 'Nunito',
              ),
              children: [
                TextSpan(text: 'I livelli di '),
                TextSpan(
                  text: 'ansia',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(
                  text: ' stanno salendo — facciamo una pausa di respiro insieme?',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(children: [
            _AlertButton(
              label: 'Andiamo 🧘',
              primary: true,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BreathingScreen()),
              ),
            ),
            const SizedBox(width: 8),
            _AlertButton(
              label: 'Magari dopo 👍',
              primary: false,
              onTap: onDismiss,
            ),
          ]),
        ],
      ),
    );
  }
}

class _AlertButton extends StatelessWidget {
  final String label;
  final bool primary;
  final VoidCallback onTap;

  const _AlertButton({
    required this.label,
    required this.primary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: primary ? Colors.white : Colors.white.withOpacity(0.22),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: primary ? AppColors.primary : Colors.white,
            fontFamily: 'Nunito',
          ),
        ),
      ),
    );
  }
}
