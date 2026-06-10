import 'package:flutter/material.dart';
import '../../core/theme.dart';
import 'exercises_detail_screen.dart';
import 'widgets/category_card.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String _activeFilter = 'Tutti';

  static const _filters = ['Tutti', 'Respirazione', 'Fitness', 'Postura'];

  static const _allCategories = [
    {'label': 'Respirazione', 'color': Color(0xFFB8D4F0), 'emoji': '🧘'},
    {'label': 'Fitness', 'color': Color(0xFFA8D8B0), 'emoji': '🏋️'},
    {'label': 'Postura', 'color': Color(0xFFBBABD8), 'emoji': '🚶'},
  ];

  @override
  Widget build(BuildContext context) {
    final categories = _activeFilter == 'Tutti'
        ? _allCategories
        : _allCategories
            .where((c) => c['label'] == _activeFilter)
            .toList();

    return Column(children: [
      const SizedBox(height: 12),
      _buildSearchBar(),
      const SizedBox(height: 12),
      _buildFilterBar(),
      const SizedBox(height: 12),
      Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, i) {
            final cat = categories[i];
            final isPostura = cat['label'] == 'Postura';
            return GestureDetector(
              onTap: isPostura
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ExerciseDetailScreen(),
                        ),
                      )
                  : null,
              child: CategoryCard(
                label: cat['label'] as String,
                color: cat['color'] as Color,
                emoji: cat['emoji'] as String,
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 16),
    ]);
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE0DDD8), width: 0.5),
        ),
        child: const Row(children: [
          SizedBox(width: 14),
          Icon(Icons.search, size: 18, color: AppColors.textMuted),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Cosa stai cercando?',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFFBBBBBB),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text('🔥', style: TextStyle(fontSize: 16)),
          SizedBox(width: 14),
        ]),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final f = _filters[i];
          final isActive = f == _activeFilter;
          return GestureDetector(
            onTap: () => setState(() => _activeFilter = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive
                      ? AppColors.primary
                      : const Color(0xFFDDDDDD),
                  width: 1,
                ),
              ),
              child: Text(
                f,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: isActive ? Colors.white : const Color(0xFF555555),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
