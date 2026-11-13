import 'package:flutter/material.dart';

import '../../shared/widgets/screen_placeholder.dart';

/// M-07 MY
class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenPlaceholder(
      title: 'MY',
      screenId: 'M-07',
      milestone: 'M4',
    );
  }
}
