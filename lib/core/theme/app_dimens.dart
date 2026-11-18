import 'package:flutter/material.dart';

/// 간격 — Figma space/1~16 (4px 단위).
abstract final class AppSpacing {
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s8 = 32;
  static const double s10 = 40;
  static const double s12 = 48;
  static const double s16 = 64;
}

/// 라운드 — Figma radius/*. 버튼 lg, 카드·사진 xl, 큰 컨테이너 2xl, 칩·검색바 full.
abstract final class AppRadius {
  static const double sm = 4;
  static const double md = 6;
  static const double lg = 8;
  static const double xl = 14;
  static const double xxl = 20;
  static const double full = 999;

  static final BorderRadius smAll = BorderRadius.circular(sm);
  static final BorderRadius mdAll = BorderRadius.circular(md);
  static final BorderRadius lgAll = BorderRadius.circular(lg);
  static final BorderRadius xlAll = BorderRadius.circular(xl);
  static final BorderRadius xxlAll = BorderRadius.circular(xxl);
  static final BorderRadius fullAll = BorderRadius.circular(full);
}

/// 그림자 — Figma shadow/card-float. 떠 있는 면에 허용되는 유일한 그림자.
/// 검색바, 카드 pressed, 드롭다운, 바텀시트, 고정 계획 카드에만 사용합니다.
abstract final class AppShadows {
  static const cardFloat = [
    BoxShadow(color: Color(0x05000000), spreadRadius: 1), // 0 0 0 1px .02
    BoxShadow(color: Color(0x0A000000), offset: Offset(0, 2), blurRadius: 6),
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 4), blurRadius: 8),
  ];

  /// 지도 위 행정동 핀 전용 (Figma DongPin 0 2 8 .16).
  static const pin = [
    BoxShadow(color: Color(0x29000000), offset: Offset(0, 2), blurRadius: 8),
  ];

  /// 세그먼트 탭의 선택 칸 전용 (Figma Mobile/SegmentedTabs 0 1 2 .06).
  static const segment = [
    BoxShadow(color: Color(0x0F000000), offset: Offset(0, 1), blurRadius: 2),
  ];
}
