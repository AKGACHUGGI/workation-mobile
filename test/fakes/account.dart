import 'package:workation_mobile/core/network/api_exception.dart';
import 'package:workation_mobile/data/models/me.dart';
import 'package:workation_mobile/data/models/popular_region.dart';
import 'package:workation_mobile/data/models/region_detail.dart';
import 'package:workation_mobile/data/repositories/favorites_repository.dart';
import 'package:workation_mobile/data/repositories/me_repository.dart';
import 'package:workation_mobile/features/auth/auth_providers.dart';

/// 처음부터 로그인된 세션(`sessionProvider.overrideWith(SignedInSession.new)`).
class SignedInSession extends SessionNotifier {
  @override
  AuthUser? build() => const AuthUser(
    id: 'u_1',
    nickname: '두이',
    initial: '두',
    provider: AuthProviderKind.kakao,
    emailMasked: 'du***@kakao.com',
  );
}

const _scores = MetricScores(
  quiet: 55,
  crowd: 37,
  peer: 48,
  overnight: 76,
  vibe: 30,
);

FavoriteRegion fakeFavoriteRegion(String id, String name, {String? note}) =>
    FavoriteRegion(
      id: id,
      name: name,
      province: '강원특별자치도',
      scores: _scores,
      tags: const ['해안', '속초시 인접'],
      note: note,
      addedAt: '2025-10-02T10:00:00+09:00',
    );

FavoriteDong fakeFavoriteDong(String id, String name, DongKind kind) =>
    FavoriteDong(
      id: id,
      name: name,
      kind: kind,
      sigungu: const FavoriteSigungu(id: '51820', name: '고성군'),
      scores: _scores,
      addedAt: '2025-10-02T10:05:00+09:00',
    );

/// 메모리 즐겨찾기. 기본은 고성군 + 거진읍(생활권) 저장 상태.
/// [failWrites] 이면 저장 · 해제가 실패하고, [limitReached] 이면 저장이 상한 오류입니다.
class FakeFavoritesRepository implements FavoritesRepository {
  FakeFavoritesRepository({
    List<FavoriteRegion>? regions,
    List<FavoriteDong>? dongs,
    this.failWrites = false,
    this.limitReached = false,
    this.failList = false,
  }) : regions =
           regions ??
           [fakeFavoriteRegion('51820', '고성군', note: '11월 2주 체류 예정')],
       dongs =
           dongs ?? [fakeFavoriteDong('5182025300', '거진읍', DongKind.living)];

  final List<FavoriteRegion> regions;
  final List<FavoriteDong> dongs;
  bool failWrites;
  bool limitReached;
  bool failList;

  /// 받은 쓰기 요청(순서대로). 예: `PUT regions/51830`
  final calls = <String>[];

  @override
  Future<FavoritesResponse> list(String month) async {
    if (failList) throw const NetworkException('/api/me/favorites');
    return FavoritesResponse(
      month: month,
      regions: [...regions],
      dongs: [...dongs],
    );
  }

  @override
  Future<FavoriteIds> ids() async => FavoriteIds(
    regions: [for (final r in regions) r.id],
    dongs: [for (final d in dongs) d.id],
  );

  @override
  Future<void> put(FavoriteKind kind, String id) async {
    calls.add('PUT ${kind.path}/$id');
    if (limitReached) throw const FavoriteLimitException();
    if (failWrites) throw const NetworkException('/api/me/favorites');
    switch (kind) {
      case FavoriteKind.regions:
        if (regions.every((r) => r.id != id)) {
          regions.add(
            fakeFavoriteRegion(id, switch (id) {
              '51830' => '양양군',
              '52140' => '정읍시',
              _ => id,
            }),
          );
        }
      case FavoriteKind.dongs:
        if (dongs.every((d) => d.id != id)) {
          dongs.add(fakeFavoriteDong(id, id, DongKind.tourist));
        }
    }
  }

  @override
  Future<void> remove(FavoriteKind kind, String id) async {
    calls.add('DELETE ${kind.path}/$id');
    if (failWrites) throw const NetworkException('/api/me/favorites');
    switch (kind) {
      case FavoriteKind.regions:
        regions.removeWhere((r) => r.id == id);
      case FavoriteKind.dongs:
        dongs.removeWhere((d) => d.id == id);
    }
  }
}

/// MY 에 쓰는 가짜. 팁 2개 · 사진 3장(검수 대기 1) · 설정은 웹 mock 의 초기 값.
class FakeMeRepository implements MeRepository {
  FakeMeRepository({this.failPatch = false});

  bool failPatch;
  MeSettings current = const MeSettings(
    notifyBestMonth: true,
    notifyTipReaction: true,
    notifyPhotoSelected: false,
  );

  /// 받은 `PATCH` 본문(바꾼 키만)
  final patches = <Map<String, bool>>[];

  @override
  Future<MeSummary> summary() async => const MeSummary(
    stays: [
      StayCount(regionName: '강릉', count: 2),
      StayCount(regionName: '고성', count: 1),
    ],
    tipCount: 2,
    photoCount: 3,
    favoriteCount: 6,
    voteCount: 3,
    createdAt: '2025-03-14T09:00:00+09:00',
  );

  @override
  Future<MyTipsResponse> tips() async => const MyTipsResponse(
    items: [
      MyTip(
        id: 'tip-1',
        author: TipAuthor(nickname: '두이', initial: '두'),
        createdAt: '2025-10-20T18:30:00+09:00',
        dongName: '거진읍',
        stayLabel: '2주 체류',
        visitMonth: '2025-10',
        body: '거진항 근처 카페는 평일 오전이 제일 조용해요.',
        helpful: 12,
        replies: 2,
        target: MyTipTarget(
          kind: TipTargetKind.region,
          id: '51820',
          name: '고성군',
        ),
      ),
      MyTip(
        id: 'tip-2',
        author: TipAuthor(nickname: '두이', initial: '두'),
        createdAt: '2025-08-03T11:00:00+09:00',
        body: '강릉 교동은 주말 저녁에 도로가 막혀요.',
        helpful: 5,
        replies: 0,
        target: MyTipTarget(
          kind: TipTargetKind.region,
          id: '51150',
          name: '강릉시',
        ),
      ),
    ],
    helpfulSum: 17,
  );

  @override
  Future<MyPhotosResponse> photos() async => const MyPhotosResponse(
    items: [
      MyPhoto(
        id: 'ph-1',
        url: 'assets/mock-photos/51820.jpg',
        month: '2025-10',
        regionName: '고성군',
        status: PhotoStatus.approved,
      ),
      MyPhoto(
        id: 'ph-2',
        url: 'assets/mock-photos/51150.jpg',
        month: '2025-07',
        regionName: '강릉시',
        status: PhotoStatus.approved,
      ),
      MyPhoto(
        id: 'ph-3',
        url: 'assets/mock-photos/50130.jpg',
        month: '2025-10',
        regionName: '서귀포시',
        status: PhotoStatus.pending,
      ),
    ],
  );

  @override
  Future<MeSettings> settings() async => current;

  @override
  Future<MeSettings> patchSettings({
    bool? notifyBestMonth,
    bool? notifyTipReaction,
    bool? notifyPhotoSelected,
  }) async {
    patches.add({
      'notifyBestMonth': ?notifyBestMonth,
      'notifyTipReaction': ?notifyTipReaction,
      'notifyPhotoSelected': ?notifyPhotoSelected,
    });
    if (failPatch) throw const NetworkException('/api/me/settings');
    return current = current.copyWith(
      notifyBestMonth: notifyBestMonth ?? current.notifyBestMonth,
      notifyTipReaction: notifyTipReaction ?? current.notifyTipReaction,
      notifyPhotoSelected: notifyPhotoSelected ?? current.notifyPhotoSelected,
    );
  }
}
