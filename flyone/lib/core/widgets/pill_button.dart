import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_constants.dart';

class PillButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isSmall;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final LinearGradient? gradient;

  const PillButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isOutlined = false,
    this.isSmall = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.gradient,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: AppConstants.pressScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.onPressed != null) _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? AppColors.deepPurple;
    final fgColor = widget.textColor ?? Colors.white;
    final height = widget.isSmall ? AppConstants.buttonHeightSmall : AppConstants.buttonHeight;
    final horizontalPad = widget.isSmall ? 16.0 : 24.0;

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: widget.width,
          height: height,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPad),
            decoration: BoxDecoration(
              color: widget.isOutlined ? Colors.transparent : (widget.gradient != null ? null : bgColor),
              gradient: widget.isOutlined ? null : widget.gradient,
              borderRadius: BorderRadius.circular(height / 2),
              border: widget.isOutlined
                  ? Border.all(color: bgColor, width: 1)
                  : null,
              boxShadow: widget.isOutlined ? null : AppConstants.shadowSubtle,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon,
                      size: widget.isSmall ? 16 : 18,
                      color: widget.isOutlined ? bgColor : fgColor),
                  const SizedBox(width: AppConstants.spaceSM),
                ],
                Text(
                  widget.label,
                  style: (widget.isSmall
                          ? AppTypography.buttonSmall
                          : AppTypography.button)
                      .copyWith(color: widget.isOutlined ? bgColor : fgColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
