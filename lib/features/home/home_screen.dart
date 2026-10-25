import 'package:flutter/material.dart';

/// M-01 홈. 명세서 화면 ID 기준으로 features/<화면>/ 폴더를 추가합니다.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('워케이션(가제)')),
      body: const Center(
        child: Text(
          '모바일 초기 구성이 완료되었습니다.\nM-01 화면부터 구현을 시작하세요.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
