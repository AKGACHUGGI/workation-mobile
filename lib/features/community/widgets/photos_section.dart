import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/metric/metric.dart';
import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../shared/widgets/photo_upload_tile.dart';
import '../../../shared/widgets/user_photo_tile.dart';
import '../../auth/auth_providers.dart';
import '../../auth/login_gate.dart';
import '../../my/my_providers.dart';
import '../community_providers.dart';
import 'photo_upload_sheet.dart';
import 'section_header.dart';

/// 이달의 사진: 사용자 사진 최대 3장 + 올리기 타일. 올리기는 로그인 뒤 올리기 시트를 열고,
/// 올리면 투표 응답(사진이 함께 옵니다)을 다시 읽어 사진 줄을 바꿉니다.
class PhotosSection extends ConsumerWidget {
  const PhotosSection({
    super.key,
    required this.target,
    required this.month,
    this.preset,
  });

  final CommunityTarget target;
  final String month;

  /// 같은 화면의 체감 투표와 같은 값을 줘야 응답을 한 번만 읽습니다. 동네는 null
  final PresetKey? preset;

  Future<void> _upload(BuildContext context, WidgetRef ref) async {
    if (!await ensureLoggedIn(context, ref)) return;
    final user = ref.read(sessionProvider);
    if (!context.mounted || user == null) return;
    final messenger = ScaffoldMessenger.of(context);
    final uploaded = await showPhotoUploadSheet(
      context,
      target: target,
      month: pollMonthOf(month),
      authorName: user.nickname,
    );
    if (!uploaded) return;
    // 사진은 프리셋과 상관없이 보이므로 이 대상의 투표 응답을 모두 다시 읽게 합니다.
    ref.invalidate(pollProvider);
    ref.invalidate(myPhotosProvider);
    ref.invalidate(meSummaryProvider);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('사진을 올렸어요')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poll = ref.watch(
      pollProvider((target: target, month: month, preset: preset)),
    );
    final photos = (poll.value?.photos ?? const <UserPhoto>[]).take(3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s4,
      children: [
        SectionHeader(
          title: '이달의 사진',
          caption: '${Months.label(pollMonthOf(month))} · 사용자 제공',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: AppSpacing.s2,
            children: [
              for (final p in photos)
                UserPhotoTile(url: p.url, author: p.author),
              PhotoUploadTile(onTap: () => _upload(context, ref)),
            ],
          ),
        ),
      ],
    );
  }
}
