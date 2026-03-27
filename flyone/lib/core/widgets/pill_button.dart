import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
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
    final height = widget.isSmall ? 44.0 : 52.0;

    // When gradient is provided, use a custom container-based button
    if (widget.gradient != null && !widget.isOutlined) {
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
              padding: EdgeInsets.symmetric(
                  horizontal: widget.isSmall ? 20 : 32),
              decoration: BoxDecoration(
                gradient: widget.gradient,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon,
                        size: widget.isSmall ? 18 : 20, color: fgColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.label,
                    style: (widget.isSmall
                            ? AppTypography.buttonSmall
                            : AppTypography.button)
                        .copyWith(color: fgColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Standard ElevatedButton with press scale
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: widget.width,
          height: height,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.isOutlined ? Colors.transparent : bgColor,
              foregroundColor: widget.isOutlined ? bgColor : fgColor,
              elevation: widget.isOutlined ? 0 : 2,
              shadowColor: AppColors.shadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
                side: widget.isOutlined
                    ? BorderSide(color: bgColor, width: 1.5)
                    : BorderSide.none,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: widget.isSmall ? 20 : 32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: widget.isSmall ? 18 : 20),
                  const SizedBox(width: 8),
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
