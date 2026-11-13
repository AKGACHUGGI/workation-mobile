import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// 하단 내비 4탭 셸 (Figma Mobile/BottomNav: 홈 · 지도 · 즐겨찾기 · MY).
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          // 이미 선택된 탭을 다시 누르면 그 탭의 첫 화면으로 돌아갑니다.
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          destinations: const [
            NavigationDestination(icon: Icon(LucideIcons.house), label: '홈'),
            NavigationDestination(icon: Icon(LucideIcons.map), label: '지도'),
            NavigationDestination(icon: Icon(LucideIcons.star), label: '즐겨찾기'),
            NavigationDestination(icon: Icon(LucideIcons.user), label: 'MY'),
          ],
        ),
      ),
    );
  }
}
