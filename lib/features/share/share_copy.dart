import '../../core/metric/month.dart';

/// 공유창으로 보낼 글을 만드는 순수 함수 모음 (M-03 · M-04).
abstract final class ShareCopy {
  /// 지역 상세. 예: `고성군 · 12월 워케이션 밸류 46점 (조용한 곳 12곳 중 8위)`
  static String region({
    required String name,
    required String month,
    required int score,
    required String preset,
    required int rank,
    required int total,
  }) =>
      '$name · ${Months.label(month)} 워케이션 밸류 $score점 '
      '($preset $total곳 중 $rank위)';

  /// 동네 프로필. 화면 하단 고정 바의 점수(조용함)를 씁니다.
  /// 집계 제외 동네는 점수가 없으므로 이름만 보냅니다.
  /// 예: `토성면, 고성군 · 12월 조용함 55점`
  static String dong({
    required String name,
    required String sigunguName,
    required String month,
    required int? quietScore,
  }) {
    final title = '$name, $sigunguName';
    if (quietScore == null) return title;
    return '$title · ${Months.label(month)} 조용함 $quietScore점';
  }

  /// [text] 뒤에 [link] 를 줄을 바꿔 붙입니다. 링크가 없으면 글만.
  static String withLink(String text, String? link) =>
      link == null ? text : '$text\n$link';

  /// 웹 지역 상세 주소. [webBaseUrl] 이 비어 있으면 null.
  /// 웹 라우터(`/regions/:sggId`)와 달 쿼리(`?month=`)를 따릅니다.
  static String? regionLink(String webBaseUrl, String id, String month) =>
      _link(webBaseUrl, '/regions/$id', month);

  /// 웹 동네 프로필 주소(`/dongs/:dongId?month=`).
  static String? dongLink(String webBaseUrl, String id, String month) =>
      _link(webBaseUrl, '/dongs/$id', month);

  static String? _link(String base, String path, String month) {
    final trimmed = base.trim().replaceFirst(RegExp(r'/+$'), '');
    if (trimmed.isEmpty) return null;
    return '$trimmed$path?month=$month';
  }
}
