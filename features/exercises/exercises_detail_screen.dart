import 'package:flutter/material.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key});

  static const _steps = [
    _Step(
      '0:00 – 0:00',
      'Trova una sedia stabile o resta in piedi. Allunga la colonna, rilassa le spalle.',
    ),
    _Step(
      '0:00 – 0:30',
      'Mani sul addome, mano sul petto. Inspira 4 — addome sale e gonfia. Espira 4 — lascia andare la tensione. Ripeti 3 volte.',
    ),
    _Step(
      '0:30 – 1:10',
      'Apri le braccia all\'altezza delle spalle: inspira aprendo il petto, espira riportando le braccia. Ripeti 6 volte.',
    ),
    _Step(
      '1:10 – 1:40',
      'Inclina il mento al petto, poi testa verso la spalla destra, torna al centro e verso sinistra. 3 ripetizioni per lato.',
    ),
    _Step(
      '1:40 – 2:10',
      'Piedi a terra: inspira alzando, poi testa verso il giro inspirando, circolo indietro e giù espirando. 5 rotazioni indietro, 5 avanti.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right: 18, bottom: 4),
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
                'Esercizio Guidato',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVideoHero(),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF1A1A1A),
                              height: 1.25,
                              fontFamily: 'Nunito',
                            ),
                            children: [
                              TextSpan(text: '6 Minuti per Schiena e\nMente: '),
                              TextSpan(
                                text: 'Postura',
                                style: TextStyle(color: Color(0xFFB060D0)),
                              ),
                              TextSpan(text: ' e '),
                              TextSpan(
                                text: 'Calma',
                                style: TextStyle(color: Color(0xFF4ABFA0)),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF444444),
                              height: 1.6,
                              fontFamily: 'Nunito',
                            ),
                            children: [
                              TextSpan(text: 'Questa pratica guidata combina '),
                              TextSpan(
                                text: 'respirazione diaframmatica',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text:
                                    ', mobilità dolce e esercizi isometrici per migliorare l\'allineamento posturale e ',
                              ),
                              TextSpan(
                                text: 'ridurre la tensione muscolare',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text:
                                    '. Adatta a chi passa molte ore al computer.\nLivello: principiante. Attrezzature: sedia stabile.\nSerie consigliata: giornaliera.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 22),
                        const Text(
                          'Contenuto',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ..._steps.map((s) => _StepTile(step: s)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildVideoHero() {
    return Stack(alignment: Alignment.center, children: [
      Container(
        height: 190,
        width: double.infinity,
        color: const Color(0xFFD4C5B8),
        child: const Center(child: Text('🧘', style: TextStyle(fontSize: 64))),
      ),
      Container(
        height: 190,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.28)],
          ),
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _VideoButton(icon: Icons.skip_previous_rounded),
        const SizedBox(width: 16),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.92),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.pause_rounded,
            size: 26,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(width: 16),
        _VideoButton(icon: Icons.skip_next_rounded),
      ]),
      const Positioned(
        left: 14,
        bottom: 10,
        child: Text(
          'Esercizio',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white70,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ]);
  }
}

class _VideoButton extends StatelessWidget {
  final IconData icon;
  const _VideoButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF1A1A1A)),
    );
  }
}

class _Step {
  final String time;
  final String description;
  const _Step(this.time, this.description);
}

class _StepTile extends StatelessWidget {
  final _Step step;
  const _StepTile({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF444444),
            height: 1.55,
            fontFamily: 'Nunito',
          ),
          children: [
            TextSpan(
              text: '${step.time}  ',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A1A),
              ),
            ),
            TextSpan(text: step.description),
          ],
        ),
      ),
    );
  }
}
