import 'package:flutter_test/flutter_test.dart';
import 'package:workation_mobile/features/share/share_copy.dart';

void main() {
  test('지역: 이름 · 달 · 점수 · 프리셋 순위를 한 줄로', () {
    expect(
      ShareCopy.region(
        name: '고성군',
        month: '2025-12',
        score: 46,
        preset: '조용한 곳',
        rank: 8,
        total: 12,
      ),
      '고성군 · 12월 워케이션 밸류 46점 (조용한 곳 12곳 중 8위)',
    );
    expect(
      ShareCopy.region(
        name: '고성군',
        month: 'annual',
        score: 46,
        preset: '조용한 곳',
        rank: 1,
        total: 12,
      ),
      contains('연간 워케이션 밸류'),
    );
  });

  test('동네: 조용함 점수가 있으면 붙이고, 집계 제외 동네는 이름만', () {
    expect(
      ShareCopy.dong(
        name: '토성면',
        sigunguName: '고성군',
        month: '2025-12',
        quietScore: 55,
      ),
      '토성면, 고성군 · 12월 조용함 55점',
    );
    expect(
      ShareCopy.dong(
        name: '수동면',
        sigunguName: '고성군',
        month: '2025-12',
        quietScore: null,
      ),
      '수동면, 고성군',
    );
  });

  test('링크: 웹 주소가 있으면 경로와 달을 붙이고, 비면 null', () {
    expect(
      ShareCopy.regionLink('https://w.example.com/', '51820', '2025-12'),
      'https://w.example.com/regions/51820?month=2025-12',
    );
    expect(
      ShareCopy.dongLink('https://w.example.com', '5115025000', 'annual'),
      'https://w.example.com/dongs/5115025000?month=annual',
    );
    expect(ShareCopy.regionLink('', '51820', '2025-12'), isNull);
    expect(ShareCopy.dongLink('  ', '5115025000', '2025-12'), isNull);
  });

  test('withLink: 링크는 다음 줄에, 없으면 글만', () {
    expect(ShareCopy.withLink('글', 'https://a.b'), '글\nhttps://a.b');
    expect(ShareCopy.withLink('글', null), '글');
  });
}
