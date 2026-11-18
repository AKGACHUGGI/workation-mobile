import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'core/network/api_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 로그인(Supabase Auth). 저장된 세션을 되살리고 OAuth 딥링크 복귀를 받습니다.
  // mock 모드이거나 Supabase 값이 없으면 건너뛰고 비로그인으로만 동작합니다.
  if (ApiConfig.authEnabled) {
    await Supabase.initialize(
      url: ApiConfig.supabaseUrl,
      publishableKey: ApiConfig.supabaseKey,
    );
  }
  runApp(const ProviderScope(child: WorkationApp()));
}
