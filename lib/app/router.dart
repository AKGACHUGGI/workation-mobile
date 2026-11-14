import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/dong/dong_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';
import '../features/map/map_screen.dart';
import '../features/my/my_screen.dart';
import '../features/region/region_screen.dart';
import '../features/search/search_screen.dart';
import 'app_shell.dart';

/// 경로 모음. 화면 ID 는 구현 플랜(docs/plans) 화면별 표 기준.
abstract final class AppRoutes {
  // 하단 탭
  static const home = '/'; // M-01
  static const map = '/map'; // M-02
  static const favorites = '/favorites'; // M-05
  static const my = '/my'; // M-07

  // 하단 내비 없이 화면 전체를 쓰는 화면
  static const search = '/search'; // M-01b

  /// M-03 지역 상세. [tab] 은 `season` · `dongs` · `info`.
  static String region(String id, {String? tab}) =>
      tab == null ? '/regions/$id' : '/regions/$id?tab=$tab';

  /// M-04 동네 프로필
  static String dong(String id) => '/dongs/$id';
}

GoRouter createRouter({String initialLocation = AppRoutes.home}) => GoRouter(
  initialLocation: initialLocation,
  routes: [
    // 탭마다 자기 스택을 유지합니다(지역 상세로 들어갔다 탭을 바꿔도 돌아오면 그대로).
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.map,
              builder: (context, state) => const MapScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favorites,
              builder: (context, state) => const FavoritesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.my,
              builder: (context, state) => const MyScreen(),
            ),
          ],
        ),
      ],
    ),
    // 아래는 셸 밖(루트 내비게이터)에 쌓여 하단 내비를 덮습니다 (Figma M-01b · M-03 · M-04).
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/regions/:id',
      builder: (context, state) => RegionScreen(
        regionId: state.pathParameters['id']!,
        initialTab: RegionTab.parse(state.uri.queryParameters['tab']),
      ),
    ),
    GoRoute(
      path: '/dongs/:id',
      builder: (context, state) =>
          DongScreen(dongId: state.pathParameters['id']!),
    ),
  ],
);

final routerProvider = Provider<GoRouter>((ref) {
  final router = createRouter();
  ref.onDispose(router.dispose);
  return router;
});
