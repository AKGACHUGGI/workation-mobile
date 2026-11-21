import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/metric/month.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/photo/photo_picker.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/community.dart';
import '../../../data/repositories/community_repository.dart';
import '../../../shared/widgets/photo_pick_strip.dart';
import '../upload_errors.dart';

/// 이달의 사진 올리기 시트를 띄웁니다. 사진을 1~3장 골라 [올리기] 를 누르면 올리고,
/// 끝나면 닫고 true. 그냥 닫으면 false. [month] 는 올릴 달(`2025-10`)입니다.
Future<bool> showPhotoUploadSheet(
  BuildContext context, {
  required CommunityTarget target,
  required String month,
  required String authorName,
}) async {
  final done = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) =>
        PhotoUploadSheet(target: target, month: month, authorName: authorName),
  );
  return done ?? false;
}

/// [showPhotoUploadSheet] 의 내용. 고르기 → 미리 보기 · 빼기 → 올리기.
/// 실패하면 고른 사진을 둔 채 시트 안에서 알립니다(스낵바는 시트 뒤에 가려집니다).
class PhotoUploadSheet extends ConsumerStatefulWidget {
  const PhotoUploadSheet({
    super.key,
    required this.target,
    required this.month,
    required this.authorName,
  });

  final CommunityTarget target;
  final String month;

  /// mock 이 작성자 표시에 씁니다(실제 API 는 세션으로 압니다).
  final String authorName;

  @override
  ConsumerState<PhotoUploadSheet> createState() => _PhotoUploadSheetState();
}

class _PhotoUploadSheetState extends ConsumerState<PhotoUploadSheet> {
  final _photos = <PickedPhoto>[];
  var _picking = false;
  var _sending = false;
  String? _error;

  Future<void> _add() async {
    final room = photoMaxCount - _photos.length;
    if (room <= 0 || _picking) return;
    setState(() {
      _picking = true;
      _error = null;
    });
    try {
      final picked = await ref.read(photoPickerProvider).pick(max: room);
      final result = checkPhotos(picked, room: room);
      if (!mounted) return;
      setState(() {
        _photos.addAll(result.accepted);
        _error = result.rejected;
      });
    } on PhotoPickException {
      if (!mounted) return;
      setState(() => _error = '사진을 불러오지 못했어요. 사진 접근 권한을 확인해 주세요');
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _submit() async {
    if (_photos.isEmpty || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref
          .read(communityRepositoryProvider)
          .uploadMonthPhotos(
            widget.target,
            widget.month,
            photos: List.unmodifiable(_photos),
            authorName: widget.authorName,
          );
      if (mounted) Navigator.of(context).pop(true);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _sending = false;
        _error = uploadErrorMessage(
          e,
          fallback: '사진을 올리지 못했어요. 잠시 후 다시 시도해 주세요',
          photos: true,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final tertiary = Theme.of(context)
        .extension<AppSemanticColors>()!
        .textTertiary;

    // 올리는 동안에는 바깥을 눌러도 닫히지 않습니다.
    return PopScope(
      canPop: !_sending,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: AppSpacing.s3,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('이달의 사진 올리기', style: AppTextStyles.headingLg),
                Text(
                  '${Months.label(widget.month)} · 사용자 제공',
                  style: AppTextStyles.captionXs.copyWith(color: tertiary),
                ),
              ],
            ),
            PhotoPickStrip(
              photos: _photos,
              size: 96,
              onAdd: _sending || _picking ? null : _add,
              onRemove: _sending
                  ? null
                  : (i) => setState(() => _photos.removeAt(i)),
            ),
            Text(
              '올리면 바로 게시돼요 · 최대 $photoMaxCount장, 한 장에 10MB 이하',
              style: AppTextStyles.captionXs.copyWith(color: tertiary),
            ),
            if (_error != null)
              Text(
                _error!,
                style: AppTextStyles.captionXs.copyWith(color: scheme.error),
              ),
            FilledButton(
              onPressed: _photos.isEmpty || _sending ? null : _submit,
              child: Text(_sending ? '올리는 중…' : '올리기'),
            ),
          ],
        ),
      ),
    );
  }
}
