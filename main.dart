import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const BioSyncApp());
}

class BioSyncApp extends StatelessWidget {
  const BioSyncApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioSync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: const Color(0xFFF5F4F0),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE8440A)),
      ),
      home: const AppShell(),
    );
  }
}

// ─────────────────────────────────────────────
// APP SHELL — gestisce la navbar globale
// ─────────────────────────────────────────────

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 2;

  void _onNavTap(int i) => setState(() => _currentIndex = i);

  @override
  Widget build(BuildContext context) {
    final screens = [
      const PlaceholderScreen(label: 'Notifiche'),
      const ExercisesScreen(),
      HomeBody(onNavTap: _onNavTap),
      const PlaceholderScreen(label: 'Calendario'),
      const PlaceholderScreen(label: 'Impostazioni'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F4F0),
      body: SafeArea(child: screens[_currentIndex]),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BOTTOM NAV
// ─────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.currentIndex, required this.onTap});

  static const _items = [
    {'icon': Icons.notifications_none, 'label': 'Notifiche'},
    {'icon': Icons.directions_run, 'label': 'Esercizi'},
    {'icon': Icons.home_outlined, 'label': 'Home'},
    {'icon': Icons.calendar_today_outlined, 'label': 'Calendario'},
    {'icon': Icons.settings_outlined, 'label': 'Impostazioni'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8E8E8), width: 0.5)),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_items.length, (i) {
          final isActive = i == currentIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_items[i]['icon'] as IconData, size: 22,
                    color: isActive ? const Color(0xFFE8440A) : const Color(0xFFBBBBBB)),
                if (isActive)
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 4, height: 4,
                    decoration: const BoxDecoration(color: Color(0xFFE8440A), shape: BoxShape.circle),
                  )
                else
                  const SizedBox(height: 6),
                Text(_items[i]['label'] as String,
                    style: TextStyle(
                        fontSize: 9, fontWeight: FontWeight.w700,
                        color: isActive ? const Color(0xFFE8440A) : const Color(0xFFBBBBBB))),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// PLACEHOLDER
// ─────────────────────────────────────────────

class PlaceholderScreen extends StatelessWidget {
  final String label;
  const PlaceholderScreen({super.key, required this.label});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF999999))),
    );
  }
}

// ─────────────────────────────────────────────
// HOME BODY
// ─────────────────────────────────────────────

class HomeBody extends StatefulWidget {
  final ValueChanged<int> onNavTap;
  const HomeBody({super.key, required this.onNavTap});
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> with SingleTickerProviderStateMixin {
  bool _alertVisible = true;
  late AnimationController _ringController;
  late Animation<double> _ringAnimation;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _ringAnimation = CurvedAnimation(parent: _ringController, curve: Curves.easeOutCubic);
    _ringController.forward();
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreeting(),
                    const SizedBox(height: 16),
                    _buildRing(),
                    const SizedBox(height: 16),
                    _buildMetricsRow(),
                    const SizedBox(height: 14),
                    if (_alertVisible) _buildAlertCard(),
                    if (_alertVisible) const SizedBox(height: 14),
                    _buildSectionTitle(),
                    const SizedBox(height: 12),
                    _buildTaskCard(icon: '🏃', title: 'Corsa mattutina', subtitle: '30 min · ore 7:00',
                        badge: '✓ Fatto', badgeColor: const Color(0xFFFFF3EF), badgeTextColor: const Color(0xFFE8440A), done: true),
                    const SizedBox(height: 10),
                    _buildTaskCard(icon: '🧘', title: 'Meditazione guidata', subtitle: '10 min · ore 12:30',
                        badge: 'Oggi', badgeColor: const Color(0xFFFFF3EF), badgeTextColor: const Color(0xFFE8440A)),
                    const SizedBox(height: 10),
                    _buildTaskCard(icon: '💧', title: 'Idratazione', subtitle: '1.4L / 2.5L obiettivo',
                        badge: '56%', badgeColor: const Color(0xFFE6F4FF), badgeTextColor: const Color(0xFF2979C9)),
                  ],
                ),
              ),
            ),
          ],
        ),
        // FAB microfono
        Positioned(
          bottom: 16,
          right: 18,
          child: Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE8440A), shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: const Color(0xFFE8440A).withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() => Padding(
    padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
      Icon(Icons.account_circle_outlined, size: 26, color: Color(0xFF555555)),
    ]),
  );

  Widget _buildGreeting() => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Bentornato', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF999999))),
      SizedBox(height: 2),
      Text('Mario Rossi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A))),
    ],
  );

  Widget _buildRing() {
    return Center(
      child: AnimatedBuilder(
        animation: _ringAnimation,
        builder: (context, _) => SizedBox(
          width: 130, height: 130,
          child: CustomPaint(
            painter: RingPainter(progress: _ringAnimation.value * 0.83),
            child: const Center(
              child: Text('83%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A))),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsRow() => Container(
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 8, offset: const Offset(0, 2))],
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    child: Row(children: [
      _buildMetric('♥', '87', 'bpm'),
      _buildDiv(),
      _buildMetric('🫁', '78%', 'SpO2'),
      _buildDiv(),
      _buildMetric('💤', '7h', 'sonno'),
      _buildDiv(),
      _buildMetric('👟', '5768', 'passi'),
    ]),
  );

  Widget _buildMetric(String icon, String value, String unit) => Expanded(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      Text(icon, style: const TextStyle(fontSize: 16)),
      const SizedBox(height: 2),
      Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
      Text(unit, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: Color(0xFFAAAAAA))),
    ]),
  );

  Widget _buildDiv() => Container(width: 0.5, height: 40, color: const Color(0xFFEEEEEE));

  Widget _buildAlertCard() => Container(
    decoration: BoxDecoration(color: const Color(0xFFE8440A), borderRadius: BorderRadius.circular(16)),
    padding: const EdgeInsets.all(14),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      RichText(
        text: const TextSpan(
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white, height: 1.45, fontFamily: 'Nunito'),
          children: [
            TextSpan(text: 'I livelli di '),
            TextSpan(text: 'ansia', style: TextStyle(fontWeight: FontWeight.w900, decoration: TextDecoration.underline)),
            TextSpan(text: ' stanno salendo — facciamo una pausa di respiro insieme?'),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Row(children: [
        _alertBtn('Andiamo 🧘', true, () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const BreathingScreen()));
        }),
        const SizedBox(width: 8),
        _alertBtn('Magari dopo 👍', false, () => setState(() => _alertVisible = false)),
      ]),
    ]),
  );

  Widget _alertBtn(String label, bool primary, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: primary ? Colors.white : Colors.white.withOpacity(0.22),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w800,
          color: primary ? const Color(0xFFE8440A) : Colors.white, fontFamily: 'Nunito')),
    ),
  );

  Widget _buildSectionTitle() => RichText(
    text: const TextSpan(
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A), height: 1.2, fontFamily: 'Nunito'),
      children: [
        TextSpan(text: 'I tuoi impegni\ndi '),
        TextSpan(text: 'oggi', style: TextStyle(color: Color(0xFFE8440A))),
      ],
    ),
  );

  Widget _buildTaskCard({required String icon, required String title, required String subtitle,
      required String badge, required Color badgeColor, required Color badgeTextColor, bool done = false}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 1))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        Container(
          width: 42, height: 42,
          decoration: BoxDecoration(color: const Color(0xFFFFF3EF), borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.center,
          child: Text(icon, style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w800,
              color: done ? const Color(0xFFAAAAAA) : const Color(0xFF1A1A1A),
              decoration: done ? TextDecoration.lineThrough : null)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFFAAAAAA))),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(20)),
          child: Text(badge, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: badgeTextColor, fontFamily: 'Nunito')),
        ),
      ]),
    );
}

// ─────────────────────────────────────────────
// EXERCISES SCREEN  (schermata 2)
// ─────────────────────────────────────────────

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  static const _categories = [
    {
      'label': 'Respirazione',
      'color': Color(0xFFB8D4F0),
      'emoji': '🧘',
    },
    {
      'label': 'Fitness',
      'color': Color(0xFFA8D8B0),
      'emoji': '🏋️',
    },
    {
      'label': 'Postura',
      'color': Color(0xFFBBABD8),
      'emoji': '🚶',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE0DDD8), width: 0.5),
            ),
            child: Row(children: [
              const SizedBox(width: 14),
              const Icon(Icons.search, size: 18, color: Color(0xFFAAAAAA)),
              const SizedBox(width: 8),
              const Expanded(
                child: Text('Cosa stai cercando?',
                    style: TextStyle(fontSize: 13, color: Color(0xFFBBBBBB), fontWeight: FontWeight.w600)),
              ),
              const Text('🔥', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 14),
            ]),
          ),
        ),
        const SizedBox(height: 20),
        // Category cards
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, i) {
              final cat = _categories[i];
              final isPostura = cat['label'] == 'Postura';
              return GestureDetector(
                onTap: isPostura
                    ? () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ExerciseDetailScreen()))
                    : null,
                child: _CategoryCard(
                  label: cat['label'] as String,
                  color: cat['color'] as Color,
                  emoji: cat['emoji'] as String,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final Color color;
  final String emoji;
  const _CategoryCard({required this.label, required this.color, required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative blob
          Positioned(
            right: -20, bottom: -20,
            child: Container(
              width: 120, height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.18),
              ),
            ),
          ),
          // Large emoji
          Positioned(
            right: 18, top: 0, bottom: 0,
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 52)),
            ),
          ),
          // Label
          Positioned(
            left: 20, top: 0, bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// EXERCISE DETAIL SCREEN  (schermata 1)
// ─────────────────────────────────────────────

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key});

  static const _steps = [
    _Step('0:00 – 0:00', 'Trova una sedia stabile o resta in piedi. Allunga la colonna, rilassa le spalle.'),
    _Step('0:00 – 0:30', 'Mani sul addome, mano sul petto. Inspira 4 — addome sale e gonfia. Espira 4 — lascia andare la tensione. Ripeti 3 volte.'),
    _Step('0:30 – 1:10', 'Apri le braccia all\'altezza delle spalle: inspira aprendo il petto, espira riportando le braccia. Ripeti 6 volte.'),
    _Step('1:10 – 1:40', 'Inclina il mento al petto, poi testa verso la spalla destra, torna al centro e verso sinistra. 3 ripetizioni per lato.'),
    _Step('1:40 – 2:10', 'Piedi a terra: inspira alzando, poi testa verso il giro inspirando, circolo indietro e giù espirando. 5 rotazioni indietro, 5 avanti.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4, right: 18, bottom: 4),
              child: Row(children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF555555)),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text('Esercizio Guidato',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A))),
              ]),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Video thumbnail
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 190,
                          width: double.infinity,
                          color: const Color(0xFFD4C5B8),
                          child: const Center(
                            child: Text('🧘', style: TextStyle(fontSize: 64)),
                          ),
                        ),
                        // Overlay gradient
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black.withOpacity(0.28)],
                            ),
                          ),
                        ),
                        // Play/pause controls
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          _VideoBtn(icon: Icons.skip_previous_rounded),
                          const SizedBox(width: 16),
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.92), shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.pause_rounded, size: 26, color: Color(0xFF1A1A1A)),
                          ),
                          const SizedBox(width: 16),
                          _VideoBtn(icon: Icons.skip_next_rounded),
                        ]),
                        // Label bottom-left
                        const Positioned(
                          left: 14, bottom: 10,
                          child: Text('Esercizio', style: TextStyle(fontSize: 11, color: Colors.white70, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A), height: 1.25, fontFamily: 'Nunito'),
                              children: [
                                TextSpan(text: '6 Minuti per Schiena e\nMente: '),
                                TextSpan(text: 'Postura', style: TextStyle(color: Color(0xFFB060D0))),
                                TextSpan(text: ' e '),
                                TextSpan(text: 'Calma', style: TextStyle(color: Color(0xFF4ABFA0))),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Description
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(fontSize: 13, color: Color(0xFF444444), height: 1.6, fontFamily: 'Nunito'),
                              children: [
                                TextSpan(text: 'Questa pratica guidata combina '),
                                TextSpan(text: 'respirazione diaframmatica', style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: ', mobilità dolce e esercizi isometrici per migliorare l\'allineamento posturale e '),
                                TextSpan(text: 'ridurre la tensione muscolare', style: TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(text: '. Adatta a chi passa molte ore al computer.\nLivello: principiante. Attrezzature: sedia stabile.\nSerie consigliata: giornaliera.'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 22),
                          // Contenuto header
                          const Text('Contenuto',
                              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A))),
                          const SizedBox(height: 14),
                          // Steps
                          ..._steps.map((s) => _StepTile(step: s)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoBtn extends StatelessWidget {
  final IconData icon;
  const _VideoBtn({required this.icon});
  @override
  Widget build(BuildContext context) => Container(
    width: 36, height: 36,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
    child: Icon(icon, size: 20, color: const Color(0xFF1A1A1A)),
  );
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
          style: const TextStyle(fontSize: 13, color: Color(0xFF444444), height: 1.55, fontFamily: 'Nunito'),
          children: [
            TextSpan(
              text: '${step.time}  ',
              style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF1A1A1A)),
            ),
            TextSpan(text: step.description),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// BREATHING SCREEN
// ─────────────────────────────────────────────

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});
  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> with TickerProviderStateMixin {
  int _secondsLeft = 88;
  bool _isPlaying = true;
  late AnimationController _breathController;
  late AnimationController _pulseController;
  late AnimationController _orbitController;
  late Animation<double> _scaleAnim;
  late Animation<double> _pulseAnim;
  String _breathLabel = 'Inspira';

  @override
  void initState() {
    super.initState();
    _breathController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _scaleAnim = Tween<double>(begin: 0.82, end: 1.0).animate(
        CurvedAnimation(parent: _breathController, curve: Curves.easeInOut));
    _breathController.addStatusListener((status) {
      if (!_isPlaying) return;
      if (status == AnimationStatus.completed) { setState(() => _breathLabel = 'Espira'); _breathController.reverse(); }
      else if (status == AnimationStatus.dismissed) { setState(() => _breathLabel = 'Inspira'); _breathController.forward(); }
    });
    _breathController.forward();
    _pulseController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    _orbitController = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
    _startTimer();
  }

  void _startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      if (!_isPlaying) return true;
      if (_secondsLeft <= 0) return false;
      setState(() => _secondsLeft--);
      return _secondsLeft > 0;
    });
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) { _breathController.forward(); _orbitController.repeat(); _startTimer(); }
    else { _breathController.stop(); _orbitController.stop(); }
  }

  String get _timerLabel {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _breathController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F2),
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Align(alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF555555)),
                onPressed: () => Navigator.pop(context),
              )),
          ),
          const Spacer(),
          AnimatedBuilder(
            animation: Listenable.merge([_scaleAnim, _pulseAnim, _orbitController]),
            builder: (context, _) {
              return SizedBox(width: 280, height: 280,
                child: Stack(alignment: Alignment.center, children: [
                  Transform.scale(scale: _pulseAnim.value * 1.18,
                    child: Container(width: 200, height: 200,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFE8440A).withOpacity(0.10)))),
                  Transform.scale(scale: _pulseAnim.value * 1.06,
                    child: Container(width: 200, height: 200,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFE8440A).withOpacity(0.13)))),
                  Transform.scale(scale: _scaleAnim.value,
                    child: Container(width: 200, height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFEA9070).withOpacity(0.28),
                        border: Border.all(color: const Color(0xFFE8440A), width: 2),
                      ),
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                        _LungsIcon(size: 44, color: const Color(0xFF3A2010)),
                        const SizedBox(height: 8),
                        Text(_breathLabel, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF3A2010))),
                      ]),
                    )),
                  Transform.rotate(angle: _orbitController.value * 2 * pi,
                    child: Transform.translate(offset: const Offset(0, -104),
                      child: Container(width: 11, height: 11,
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF3A2010))))),
                ]),
              );
            },
          ),
          const Spacer(),
          Text(_timerLabel,
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A), letterSpacing: 2)),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              width: 54, height: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFE8440A), shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: const Color(0xFFE8440A).withOpacity(0.35), blurRadius: 16, offset: const Offset(0, 4))],
              ),
              child: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 26),
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}

class _LungsIcon extends StatelessWidget {
  final double size;
  final Color color;
  const _LungsIcon({required this.size, required this.color});
  @override
  Widget build(BuildContext context) => CustomPaint(size: Size(size, size), painter: _LungsPainter(color: color));
}

class _LungsPainter extends CustomPainter {
  final Color color;
  const _LungsPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.07..strokeCap = StrokeCap.round..strokeJoin = StrokeJoin.round;
    final w = size.width; final h = size.height;
    final path = Path();
    path.moveTo(w * 0.5, h * 0.05); path.lineTo(w * 0.5, h * 0.38);
    path.moveTo(w * 0.5, h * 0.28); path.quadraticBezierTo(w * 0.28, h * 0.28, w * 0.22, h * 0.42);
    path.moveTo(w * 0.22, h * 0.42);
    path.cubicTo(w * 0.04, h * 0.44, w * 0.04, h * 0.90, w * 0.28, h * 0.92);
    path.cubicTo(w * 0.40, h * 0.93, w * 0.44, h * 0.78, w * 0.44, h * 0.60); path.lineTo(w * 0.44, h * 0.38);
    path.moveTo(w * 0.5, h * 0.28); path.quadraticBezierTo(w * 0.72, h * 0.28, w * 0.78, h * 0.42);
    path.moveTo(w * 0.78, h * 0.42);
    path.cubicTo(w * 0.96, h * 0.44, w * 0.96, h * 0.90, w * 0.72, h * 0.92);
    path.cubicTo(w * 0.60, h * 0.93, w * 0.56, h * 0.78, w * 0.56, h * 0.60); path.lineTo(w * 0.56, h * 0.38);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(_LungsPainter old) => old.color != color;
}

// ─────────────────────────────────────────────
// RING PAINTER
// ─────────────────────────────────────────────

class RingPainter extends CustomPainter {
  final double progress;
  const RingPainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    const strokeWidth = 11.0;
    canvas.drawCircle(center, radius, Paint()..color = const Color(0xFFEDE9E3)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, 2 * pi * progress, false,
        Paint()..color = const Color(0xFFE8440A)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
    if (progress > 0.05) {
      final endAngle = -pi / 2 + 2 * pi * progress;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), endAngle - 0.12, 0.12, false,
          Paint()..color = const Color(0xFF222222)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round);
    }
  }
  @override
  bool shouldRepaint(RingPainter old) => old.progress != progress;
}
