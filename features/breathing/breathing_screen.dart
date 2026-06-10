import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'widgets/lungs_painter.dart';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with TickerProviderStateMixin {
  int _secondsLeft = 98; // 4 + 4 + 6 = 14s per ciclo × ~7 cicli
  bool _isPlaying = true;
  late AnimationController _breathController;
  late AnimationController _holdController;
  late AnimationController _pulseController;
  late AnimationController _orbitController;
  late Animation<double> _scaleAnim;
  late Animation<double> _pulseAnim;

  // Tre fasi: inhale → hold → exhale
  String _breathLabel = 'Inspira';
  String _breathSubLabel = '4 secondi';

  void _startInhale() {
    setState(() {
      _breathLabel = 'Inspira';
      _breathSubLabel = '4 secondi';
    });
    _breathController.duration = const Duration(seconds: 4);
    _breathController.forward(from: 0);
  }

  void _startHold() {
    setState(() {
      _breathLabel = 'Tieni';
      _breathSubLabel = '4 secondi';
    });
    // Cerchio rimane espanso: aspettiamo 4s con un controller dedicato
    _holdController.forward(from: 0);
  }

  void _startExhale() {
    setState(() {
      _breathLabel = 'Espira';
      _breathSubLabel = '6 secondi';
    });
    _breathController.duration = const Duration(seconds: 6);
    _breathController.reverse(from: 1);
  }

  @override
  void initState() {
    super.initState();

    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _scaleAnim = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
    _breathController.addStatusListener((status) {
      if (!_isPlaying) return;
      if (status == AnimationStatus.completed) _startHold();
      if (status == AnimationStatus.dismissed) _startInhale();
    });

    // Controller per la fase "tieni": dura 4s, poi lancia l'espirazione
    _holdController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _holdController.addStatusListener((status) {
      if (!_isPlaying) return;
      if (status == AnimationStatus.completed) _startExhale();
    });

    _breathController.forward();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

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
    if (_isPlaying) {
      // Riprendi dalla fase corrente
      if (_breathLabel == 'Tieni') {
        _holdController.forward();
      } else if (_breathLabel == 'Inspira') {
        _breathController.forward();
      } else {
        _breathController.reverse();
      }
      _orbitController.repeat();
      _startTimer();
    } else {
      _breathController.stop();
      _holdController.stop();
      _orbitController.stop();
    }
  }

  String get _timerLabel {
    final m = _secondsLeft ~/ 60;
    final s = _secondsLeft % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Widget _breathStep(String label, String duration, bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? AppColors.primary.withValues(alpha: 0.4)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: isActive ? AppColors.primary : AppColors.textMuted,
          ),
        ),
        Text(
          duration,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color:
                isActive ? const Color(0xFF3A2010) : const Color(0xFFCCCCCC),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _breathController.dispose();
    _holdController.dispose();
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: Color(0xFF555555),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
          const Spacer(),
          AnimatedBuilder(
            animation:
                Listenable.merge([_scaleAnim, _pulseAnim, _orbitController]),
            builder: (context, _) {
              return SizedBox(
                width: 280,
                height: 280,
                child: Stack(alignment: Alignment.center, children: [
                  Transform.scale(
                    scale: _pulseAnim.value * 1.18,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.10),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _pulseAnim.value * 1.06,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withValues(alpha: 0.13),
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: _scaleAnim.value,
                    child: Semantics(
                      label: '$_breathLabel — $_breathSubLabel',
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFEA9070).withValues(alpha: 0.28),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LungsIcon(
                              size: 44,
                              color: const Color(0xFF3A2010),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _breathLabel,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3A2010),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _breathSubLabel,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF7A5040),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: _orbitController.value * 2 * pi,
                    child: Transform.translate(
                      offset: const Offset(0, -104),
                      child: Container(
                        width: 11,
                        height: 11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF3A2010),
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _breathStep('Inspira', '4s', _breathLabel == 'Inspira'),
                _breathStep('Tieni', '4s', _breathLabel == 'Tieni'),
                _breathStep('Espira', '6s', _breathLabel == 'Espira'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _timerLabel,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: AppColors.dark,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: _togglePlay,
            child: Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}