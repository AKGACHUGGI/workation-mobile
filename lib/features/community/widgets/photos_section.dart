import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/metric/month.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../shared/widgets/photo_upload_tile.dart';
import '../../../shared/widgets/user_photo_tile.dart';
import '../../auth/login_gate.dart';
import '../community_providers.dart';
import 'section_header.dart';

/// 이달의 사진: 사용자 사진 최대 3장 + 올리기 타일. 올리기는 로그인 뒤 "준비 중" 안내까지입니다
/// (사진 선택 플러그인은 다음 단계).
class PhotosSection extends ConsumerWidget {
  const PhotosSection({super.key, required this.target, required this.month});

  final CommunityTarget target;
  final String month;

  Future<void> _upload(BuildContext context, WidgetRef ref) async {
    if (!await ensureLoggedIn(context, ref)) return;
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('사진 올리기 기능은 준비 중이에요')));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final poll = ref.watch(pollProvider((target: target, month: month)));
    final photos = (poll.value?.photos ?? const <UserPhoto>[]).take(3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: AppSpacing.s4,
      children: [
        SectionHeader(
          title: '이달의 사진',
          caption: '${Months.label(pollMonthOf(month))} · 사용자 제공 · 검수 후 게시',
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
