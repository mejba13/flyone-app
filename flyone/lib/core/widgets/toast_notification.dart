import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_constants.dart';

enum ToastType { success, error, info }

class ToastNotification {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    bool removed = false;

    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        onDismiss: () {
          if (!removed) {
            removed = true;
            entry.remove();
          }
        },
        duration: duration,
      ),
    );

    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;
  final Duration duration;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      if (mounted) widget.onDismiss();
    });
  }

  IconData get _icon => switch (widget.type) {
        ToastType.success => Icons.check_circle_rounded,
        ToastType.error => Icons.error_rounded,
        ToastType.info => Icons.info_rounded,
      };

  Color get _color => switch (widget.type) {
        ToastType.success => AppColors.success,
        ToastType.error => AppColors.error,
        ToastType.info => AppColors.teal,
      };

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            boxShadow: AppConstants.shadowSubtle,
            border: Border.all(color: _color.withValues(alpha: 0.2)),
          ),
          child: Row(
            children: [
              Icon(_icon, color: _color, size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(widget.message, style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary)),
              ),
              GestureDetector(
                onTap: widget.onDismiss,
                child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
              ),
            ],
          ),
        )
            .animate()
            .slideY(
              begin: -1.2,
              end: 0,
              duration: 400.ms,
              curve: Curves.easeOutBack,
            )
            .fadeIn(duration: 250.ms),
      ),
    );
  }
}
