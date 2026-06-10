import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../widgets/ring_painter.dart';
import 'widgets/alert_card.dart';
import 'widgets/metrics_row.dart';
import 'widgets/smart_break_banner.dart';

class HomeBody extends StatefulWidget {
  final ValueChanged<int> onNavTap;
  const HomeBody({super.key, required this.onNavTap});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody>
    with SingleTickerProviderStateMixin {
  bool _alertVisible = true;
  bool _smartBreakVisible = true;
  late AnimationController _ringController;
  late Animation<double> _ringAnimation;

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _ringAnimation = CurvedAnimation(
      parent: _ringController,
      curve: Curves.easeOutCubic,
    );
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
        Column(children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(),
                  const SizedBox(height: 16),
                  _buildRing(),
                  const SizedBox(height: 16),
                  const MetricsRow(),
                  const SizedBox(height: 14),
                  if (_smartBreakVisible) ...[
                    SmartBreakBanner(
                      onDismiss: () =>
                          setState(() => _smartBreakVisible = false),
                    ),
                    const SizedBox(height: 14),
                  ],
                  if (_alertVisible) ...[
                    AlertCard(
                      onDismiss: () => setState(() => _alertVisible = false),
                    ),
                    const SizedBox(height: 14),
                  ],
                  _buildSectionTitle(),
                  const SizedBox(height: 12),
                  _buildTaskCard(
                    icon: '🏃',
                    title: 'Corsa mattutina',
                    subtitle: '30 min · ore 7:00',
                    badge: '✓ Fatto',
                    badgeColor: AppColors.primaryLight,
                    badgeTextColor: AppColors.primary,
                    done: true,
                  ),
                  const SizedBox(height: 10),
                  _buildTaskCard(
                    icon: '🧘',
                    title: 'Meditazione guidata',
                    subtitle: '10 min · ore 12:30',
                    badge: 'Oggi',
                    badgeColor: AppColors.primaryLight,
                    badgeTextColor: AppColors.primary,
                  ),
                  const SizedBox(height: 10),
                  _buildTaskCard(
                    icon: '💧',
                    title: 'Idratazione',
                    subtitle: '1.4L / 2.5L obiettivo',
                    badge: '56%',
                    badgeColor: AppColors.blueLight,
                    badgeTextColor: AppColors.blue,
                  ),
                ],
              ),
            ),
          ),
        ]),
        // FAB microfono
        Positioned(
          bottom: 16,
          right: 18,
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 8, 18, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.account_circle_outlined,
            size: 26,
            color: Color(0xFF555555),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bentornato',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF999999),
          ),
        ),
        SizedBox(height: 2),
        Text(
          'Mario Rossi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.dark,
          ),
        ),
      ],
    );
  }

  Widget _buildRing() {
    return Center(
      child: AnimatedBuilder(
        animation: _ringAnimation,
        builder: (context, _) => SizedBox(
          width: 130,
          height: 130,
          child: CustomPaint(
            painter: RingPainter(progress: _ringAnimation.value * 0.83),
            child: const Center(
              child: Text(
                '83%',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: AppColors.dark,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle() {
    return RichText(
      text: const TextSpan(
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w900,
          color: AppColors.dark,
          height: 1.2,
          fontFamily: 'Nunito',
        ),
        children: [
          TextSpan(text: 'I tuoi impegni\ndi '),
          TextSpan(
            text: 'oggi',
            style: TextStyle(color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String icon,
    required String title,
    required String subtitle,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    bool done = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(icon, style: const TextStyle(fontSize: 20)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: done ? AppColors.textMuted : AppColors.dark,
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            badge,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: badgeTextColor,
              fontFamily: 'Nunito',
            ),
          ),
        ),
      ]),
    );
  }
}
