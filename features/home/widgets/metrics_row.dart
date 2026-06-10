import 'package:flutter/material.dart';
import '../../../core/theme.dart';

class MetricsRow extends StatelessWidget {
  const MetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(children: [
        _MetricCell(icon: '👟', value: '3000', unit: 'passi'),
        const _Divider(),
        _MetricCell(icon: '🫁', value: '78%', unit: 'SpO2'),
        const _Divider(),
        _MetricCell(icon: '💤', value: '7h', unit: 'sonno'),
        const _Divider(),
        _HrvCell(),
      ]),
    );
  }
}

class _MetricCell extends StatelessWidget {
  final String icon;
  final String value;
  final String unit;

  const _MetricCell({
    required this.icon,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.dark,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _HrvCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _showHrvDialog(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('❤️‍🩹', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  '42',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.dark,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.info_outline, size: 10, color: AppColors.primary),
              ],
            ),
            const Text(
              'HRV ms',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHrvDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(children: [
          Text('❤️‍🩹', style: TextStyle(fontSize: 20)),
          SizedBox(width: 8),
          Text(
            'HRV — Variabilità',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
              color: AppColors.dark,
            ),
          ),
        ]),
        content: const Text(
          'La Variabilità della Frequenza Cardiaca (HRV) misura le piccole variazioni di tempo tra un battito e l\'altro.\n\n'
          '• Alta HRV → sistema nervoso rilassato e reattivo\n'
          '• Bassa HRV → stress elevato o recupero insufficiente\n\n'
          'Valori normali: 20–100 ms (dipende da età e condizione fisica).\n'
          'Il tuo valore attuale è nella norma. 💚',
          style: TextStyle(
            fontSize: 13,
            color: Color(0xFF444444),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Capito!',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5,
      height: 40,
      color: AppColors.divider,
    );
  }
}
