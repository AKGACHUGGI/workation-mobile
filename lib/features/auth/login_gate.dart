import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/router.dart';
import 'auth_providers.dart';

/// 로그인이 필요한 동작(저장 · 팁 · 투표 · 사진) 앞에서 부릅니다.
/// 이미 로그인했으면 바로 true, 아니면 M-06 로그인 화면을 띄우고
/// 로그인을 마치면 true, 닫거나 둘러보기를 고르면 false 를 돌려줍니다.
Future<bool> ensureLoggedIn(BuildContext context, WidgetRef ref) async {
  if (ref.read(isLoggedInProvider)) return true;
  final ok = await context.push<bool>(AppRoutes.login);
  return ok ?? false;
}
