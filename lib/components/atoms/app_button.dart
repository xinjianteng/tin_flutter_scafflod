/// 使用方法：AppButton(label: '提交', onPressed: onSubmit);
import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

enum AppButtonStyle {
  primary,
  secondary,
}

/// 原子按钮：统一处理加载/禁用/样式。
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
    this.style = AppButtonStyle.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;
  final AppButtonStyle style;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed =
        (isDisabled || isLoading) ? null : onPressed;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final buttonChild = isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    style == AppButtonStyle.primary
                        ? Colors.white
                        : colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    final button = ElevatedButton(
      onPressed: effectiveOnPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: style == AppButtonStyle.primary
            ? colorScheme.primary
            : AppColors.btnBackground,
        foregroundColor: style == AppButtonStyle.primary
            ? Colors.white
            : colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: buttonChild,
    );

    if (!fullWidth) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
