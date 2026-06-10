import 'package:flutter/material.dart';
import '../../core/theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _heartRateMax = 100;
  double _spo2Min = 94;
  double _sleepTarget = 8;
  double _stepsTarget = 8000;
  double _hydrationTarget = 2.5;
  bool _smartBreakEnabled = true;
  bool _anxietyAlertEnabled = true;
  bool _savedIndicator = false;

  void _save() {
    setState(() => _savedIndicator = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _savedIndicator = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTopBar(),
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionHeader('📊  Limiti Biometrici'),
              _settingsCard(children: [
                _sliderRow(
                  icon: '♥',
                  label: 'FC massima',
                  unit: 'bpm',
                  value: _heartRateMax,
                  min: 80,
                  max: 200,
                  divisions: 120,
                  onChanged: (v) => setState(() => _heartRateMax = v),
                  displayValue: _heartRateMax.round().toString(),
                ),
                _divider(),
                _sliderRow(
                  icon: '🫁',
                  label: 'SpO2 minima',
                  unit: '%',
                  value: _spo2Min,
                  min: 85,
                  max: 99,
                  divisions: 14,
                  onChanged: (v) => setState(() => _spo2Min = v),
                  displayValue: _spo2Min.round().toString(),
                ),
              ]),
              _sectionHeader('🎯  Obiettivi Quotidiani'),
              _settingsCard(children: [
                _sliderRow(
                  icon: '💤',
                  label: 'Ore di sonno',
                  unit: 'h',
                  value: _sleepTarget,
                  min: 4,
                  max: 12,
                  divisions: 8,
                  onChanged: (v) => setState(() => _sleepTarget = v),
                  displayValue: _sleepTarget.round().toString(),
                ),
                _divider(),
                _sliderRow(
                  icon: '👟',
                  label: 'Passi giornalieri',
                  unit: '',
                  value: _stepsTarget,
                  min: 2000,
                  max: 20000,
                  divisions: 18,
                  onChanged: (v) => setState(() => _stepsTarget = v),
                  displayValue: _stepsTarget.round().toStringAsFixed(0),
                ),
                _divider(),
                _sliderRow(
                  icon: '💧',
                  label: 'Idratazione',
                  unit: 'L',
                  value: _hydrationTarget,
                  min: 1.0,
                  max: 4.0,
                  divisions: 6,
                  onChanged: (v) => setState(() => _hydrationTarget = v),
                  displayValue: _hydrationTarget.toStringAsFixed(1),
                ),
              ]),
              _sectionHeader('🔔  Avvisi & Notifiche'),
              _settingsCard(children: [
                _toggleRow(
                  icon: '☕',
                  label: 'Pausa Intelligente',
                  subtitle: 'Suggerisce pause tra i meeting',
                  value: _smartBreakEnabled,
                  onChanged: (v) => setState(() => _smartBreakEnabled = v),
                ),
                _divider(),
                _toggleRow(
                  icon: '🧠',
                  label: 'Allerta Ansia',
                  subtitle: 'Notifica quando i livelli salgono',
                  value: _anxietyAlertEnabled,
                  onChanged: (v) => setState(() => _anxietyAlertEnabled = v),
                ),
              ]),
              const SizedBox(height: 28),
              _buildSummaryCard(),
              const SizedBox(height: 16),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 8),
      child: Row(children: [
        const Icon(Icons.settings_outlined, size: 22, color: AppColors.primary),
        const SizedBox(width: 10),
        const Text(
          'Il Mio Profilo',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: AppColors.dark,
          ),
        ),
        const Spacer(),
        if (_savedIndicator)
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFE8FFE8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.check_circle_outline,
                  size: 14, color: Color(0xFF2E7D32)),
              SizedBox(width: 4),
              Text(
                'Salvato!',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2E7D32),
                ),
              ),
            ]),
          ),
      ]),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Riepilogo configurazione',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        _summaryLine('FC massima', '${_heartRateMax.round()} bpm'),
        _summaryLine('SpO2 minima', '${_spo2Min.round()}%'),
        _summaryLine('Sonno obiettivo', '${_sleepTarget.round()} ore'),
        _summaryLine('Passi obiettivo', '${_stepsTarget.round()}'),
        _summaryLine(
            'Idratazione obiettivo', '${_hydrationTarget.toStringAsFixed(1)} L'),
        _summaryLine(
            'Pausa Intelligente', _smartBreakEnabled ? 'Attiva' : 'Disattiva'),
        _summaryLine(
            'Allerta Ansia', _anxietyAlertEnabled ? 'Attiva' : 'Disattiva'),
      ]),
    );
  }

  Widget _buildSaveButton() {
    return GestureDetector(
      onTap: _save,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.30),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.save_outlined, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text(
              'Salva profilo',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w900,
            color: AppColors.dark,
          ),
        ),
      ]),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
          color: Color(0xFF444444),
        ),
      ),
    );
  }

  Widget _settingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _divider() {
    return const Divider(
      height: 0,
      thickness: 0.5,
      indent: 16,
      endIndent: 16,
      color: Color(0xFFF0F0F0),
    );
  }

  Widget _sliderRow({
    required String icon,
    required String label,
    required String unit,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required ValueChanged<double> onChanged,
    required String displayValue,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.dark,
            ),
          ),
          const Spacer(),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$displayValue $unit'.trim(),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: AppColors.primary,
              ),
            ),
          ),
        ]),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.primary,
            inactiveTrackColor: const Color(0xFFF0EDEA),
            thumbColor: AppColors.primary,
            overlayColor: AppColors.primary.withValues(alpha: 0.15),
            trackHeight: 3,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ]),
    );
  }

  Widget _toggleRow({
    required String icon,
    required String label,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: AppColors.dark,
                ),
              ),
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
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.primary,
          inactiveThumbColor: const Color(0xFFCCCCCC),
          inactiveTrackColor: AppColors.divider,
        ),
      ]),
    );
  }
}
