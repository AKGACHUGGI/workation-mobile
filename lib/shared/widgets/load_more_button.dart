import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';

/// 목록 아래의 [더 보기]. 누르면 [onLoad] 가 끝날 때까지 돌아가는 표시를 보여 주고,
/// 실패(false)하면 안내를 띄웁니다. 다음 쪽이 없으면 이 버튼을 그리지 않습니다.
class LoadMoreButton extends StatefulWidget {
  const LoadMoreButton({
    super.key,
    required this.onLoad,
    this.label = '더 보기',
    this.failMessage = '더 불러오지 못했어요',
  });

  /// 다음 쪽을 이어 붙입니다. 실패하면 false.
  final Future<bool> Function() onLoad;
  final String label;
  final String failMessage;

  @override
  State<LoadMoreButton> createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  bool _loading = false;

  Future<void> _load() async {
    final messenger = ScaffoldMessenger.of(context);
    setState(() => _loading = true);
    final ok = await widget.onLoad();
    if (mounted) setState(() => _loading = false);
    if (!ok) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(widget.failMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _loading ? null : _load,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.lgAll),
      ),
      child: _loading
          ? const SizedBox.square(
              dimension: 16,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Text(widget.label),
    );
  }
}
