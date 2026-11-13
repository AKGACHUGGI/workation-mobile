import 'package:flutter/material.dart';

import '../../shared/widgets/screen_placeholder.dart';

/// M-05 즐겨찾기
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPlaceholder(
      title: '즐겨찾기',
      screenId: 'M-05',
      milestone: 'M4',
    );
  }
}
