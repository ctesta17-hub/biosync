import 'package:biosync/main.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

class SmartBreakScreen extends StatefulWidget {
  const SmartBreakScreen({super.key});

  @override
  State<SmartBreakScreen> createState() => _SmartBreakScreenState();
}

class _SmartBreakScreenState extends State<SmartBreakScreen> {
  int? _selectedOption;

  static const _options = [
    {
      'emoji': '⚡',
      'title': 'Reset Rapido',
      'duration': '5 min',
      'description':
          'Respirazione + stretching in piedi. Ideale tra un meeting e l\'altro.',
      'color': AppColors.primaryLight,
      'accentColor': AppColors.primary,
    },
    {
      'emoji': '🌊',
      'title': 'Reset Profondo',
      'duration': '15 min',
      'description': 'Meditazione guidata + mobilità. Per ricaricarsi davvero.',
      'color': AppColors.blueLight,
      'accentColor': AppColors.blue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right: 18),
            child: Row(children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Color(0xFF555555),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              const Text(
                'Pausa Intelligente',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 24),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.dark,
                        height: 1.2,
                        fontFamily: 'Nunito',
                      ),
                      children: [
                        TextSpan(text: 'Che tipo di\n'),
                        TextSpan(
                          text: 'reset',
                          style: TextStyle(color: AppColors.primary),
                        ),
                        TextSpan(text: ' vuoi?'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(_options.length, (i) => _buildOptionCard(i)),
                  const SizedBox(height: 28),
                  _buildStartButton(context),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        const Text('☕', style: TextStyle(fontSize: 28)),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '18 minuti prima del prossimo meeting',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Scegli il tipo di pausa che vuoi fare. Staccare adesso ti aiuterà a essere più presente.',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildOptionCard(int i) {
    final opt = _options[i];
    final isSelected = _selectedOption == i;
    final accent = opt['accentColor'] as Color;
    final bg = opt['color'] as Color;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => setState(() => _selectedOption = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? bg : AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? accent.withValues(alpha: 0.5) : AppColors.divider,
              width: isSelected ? 1.5 : 0.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child:
                  Text(opt['emoji'] as String, style: const TextStyle(fontSize: 26)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Text(
                      opt['title'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: AppColors.dark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        opt['duration'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: accent,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text(
                    opt['description'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF888888),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              )
            else
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFDDDDDD), width: 1.5),
                  shape: BoxShape.circle,
                ),
              ),
          ]),
        ),
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return AnimatedOpacity(
      opacity: _selectedOption != null ? 1.0 : 0.35,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: _selectedOption == null
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SmartBreakSessionScreen(
                      optionIndex: _selectedOption!,
                      optionData: _options[_selectedOption!],
                    ),
                  ),
                ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _selectedOption != null
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inizia Reset',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
