import 'package:flutter/material.dart';

import '../../shared/widgets/screen_placeholder.dart';

/// M-02 지도
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPlaceholder(
      title: '지도',
      screenId: 'M-02',
      milestone: 'M3',
    );
  }
}
