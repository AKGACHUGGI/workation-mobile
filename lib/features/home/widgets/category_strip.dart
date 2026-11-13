import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/metric/metric.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/popular_region.dart';
import '../../../shared/widgets/category_tab.dart';
import '../home_providers.dart';

/// 홈 카테고리 스트립 (웹 `popular/categories.ts` 와 같은 8칸).
/// 지형 3칸은 거르기, 조용한 곳 · 또래 · 저녁 활기는 프리셋 바꾸기입니다.
/// 한 달 살기 · 워케이션은 아직 동작이 없습니다(체류 필터 검토 전).
class CategoryStrip extends StatelessWidget {
  const CategoryStrip({
    super.key,
    required this.filter,
    required this.onTerrain,
    required this.onPreset,
  });

  final HomeFilter filter;
  final ValueChanged<Terrain> onTerrain;
  final ValueChanged<PresetKey> onPreset;

  @override
  Widget build(BuildContext context) {
    Widget terrain(Terrain t, IconData icon) => CategoryTab(
      icon: icon,
      label: t.label,
      active: filter.terrain == t,
      onTap: () => onTerrain(t),
    );
    Widget preset(String label, IconData icon, PresetKey p) =>
        CategoryTab(icon: icon, label: label, onTap: () => onPreset(p));

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.s5,
        children: [
          terrain(Terrain.coast, LucideIcons.waves),
          terrain(Terrain.mountain, LucideIcons.mountain),
          terrain(Terrain.city, LucideIcons.building),
          preset('조용한 곳', LucideIcons.coffee, PresetKey.quiet),
          const CategoryTab(icon: LucideIcons.calendar, label: '한 달 살기'),
          preset('또래', LucideIcons.users, PresetKey.lively),
          preset('저녁 활기', LucideIcons.moon, PresetKey.lively),
          const CategoryTab(icon: LucideIcons.laptop, label: '워케이션'),
        ],
      ),
    );
  }
}
