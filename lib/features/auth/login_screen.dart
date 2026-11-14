import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'auth_providers.dart';

/// M-06 로그인 (자리표시). 로그인하면 `pop(true)`, 닫으면 `pop(false)` 입니다.
class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final kind in AuthProviderKind.values)
              FilledButton(
                onPressed: () {
                  ref.read(sessionProvider.notifier).signInMock(kind);
                  context.pop(true);
                },
                child: Text('${kind.label}로 시작하기'),
              ),
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('둘러보기'),
            ),
          ],
        ),
      ),
    );
  }
}
