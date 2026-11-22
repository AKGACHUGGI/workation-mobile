import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/me.dart';
import '../../../shared/widgets/app_photo.dart';
import '../../../shared/widgets/avatar.dart';

/// 내가 올린 사진 한 칸 (Figma UserPhotoTile). 아래쪽 그라데이션 위에
/// 아바타 + `10월 · 고성군`. 사진은 올리면 바로 공개되고, 신고가 쌓여 가려진 사진(`pending`)은
/// 흐리게 보이고 `신고로 가려짐` 배지가 붙습니다(웹과 같음). [onDelete] 를 주면 오른쪽 위에
/// 삭제 버튼을 둡니다.
///
/// MY 전용입니다. 지역 · 동네 상세의 사진 목록용 공용 `UserPhotoTile` 은 따로 만들어집니다.
class MyPhotoTile extends StatelessWidget {
  const MyPhotoTile({
    super.key,
    required this.photo,
    required this.initial,
    this.onDelete,
  });

  final MyPhoto photo;

  /// 삭제 버튼을 눌렀을 때. null 이면 버튼을 그리지 않습니다.
  final VoidCallback? onDelete;

  /// 아바타 글자(내 닉네임 첫 글자)
  final String initial;

  /// `assets/mock-photos/…` · `/mock-photos/…` 어느 쪽이든 번들 경로로 맞춥니다.
  static String assetUrl(String url) =>
      url.startsWith('/mock-photos/') ? 'assets$url' : url;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pending = photo.status == PhotoStatus.pending;

    return Semantics(
      label:
          '${photo.regionName} ${Months.label(photo.month)} 사진'
          '${pending ? ' 신고로 가려짐' : ''}',
      child: ClipRRect(
        borderRadius: AppRadius.lgAll,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: pending ? 0.6 : 1,
              child: AppPhoto(assetUrl(photo.url)),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    scheme.shadow.withValues(alpha: 0),
                    scheme.shadow.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            if (pending)
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s2,
                    vertical: AppSpacing.s1,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.inverseSurface,
                    borderRadius: AppRadius.mdAll,
                  ),
                  child: Text(
                    '신고로 가려짐',
                    style: AppTextStyles.captionBadge.copyWith(
                      color: scheme.onInverseSurface,
                    ),
                  ),
                ),
              ),
            if (onDelete != null)
              Positioned(
                top: 6,
                right: 6,
                // 사진 설명과 합쳐지지 않게 따로 읽히는 버튼으로 둡니다.
                child: Semantics(
                  container: true,
                  button: true,
                  label: '사진 삭제',
                  excludeSemantics: true,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: onDelete,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: scheme.shadow.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.trash2,
                        size: 16,
                        color: scheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            Positioned(
              left: 6,
              bottom: 6,
              child: Row(
                spacing: AppSpacing.s1,
                children: [
                  Avatar(initial: initial, size: AvatarSize.sm),
                  Text(
                    '${Months.label(photo.month)} · ${photo.regionName}',
                    style: AppTextStyles.captionXsMedium.copyWith(
                      color: scheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 사진 올리기 칸 (Figma PhotoUploadTile). 점선 테두리. 이달의 사진은 지역 화면에서 올리므로
/// MY 에서는 누르면 그곳을 안내합니다.
class MyPhotoUploadTile extends StatelessWidget {
  const MyPhotoUploadTile({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Semantics(
      button: true,
      label: '이달의 사진 올리기',
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: CustomPaint(
          painter: _DashedBorder(color: scheme.outline, radius: AppRadius.lg),
          child: Container(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: AppRadius.lgAll,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.s1,
              children: [
                Icon(
                  LucideIcons.camera,
                  size: 20,
                  color: scheme.onSurfaceVariant,
                ),
                Text(
                  '이달의 사진 올리기',
                  style: AppTextStyles.captionXsMedium.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorder extends CustomPainter {
  const _DashedBorder({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ).deflate(0.5),
      );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
        d += 8;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorder old) =>
      old.color != color || old.radius != radius;
}
