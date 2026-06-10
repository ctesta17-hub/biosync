import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'widgets/bottom_nav.dart';
import 'widgets/placeholder_screen.dart';
import 'features/home/home_body.dart';
import 'features/exercises/exercises_screen.dart';
import 'features/settings/settings_screen.dart';

class BioSyncApp extends StatelessWidget {
  const BioSyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BioSync',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const AppShell(),
    );
  }
}

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
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: screens[_currentIndex]),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
