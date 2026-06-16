import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  text,
  danger,
  success,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool expanded;
  final bool loading;
  final IconData? icon;
  final Widget? trailingIcon;
  final Color? customColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.expanded = false,
    this.loading = false,
    this.icon,
    this.trailingIcon,
    this.customColor,
    this.borderRadius,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = onPressed == null || loading;

    final backgroundColor = _getBackgroundColor(theme, isDisabled);
    final foregroundColor = _getForegroundColor(theme, isDisabled);
    final borderColor = _getBorderColor(theme, isDisabled);
    final effectivePadding = _getPadding();
    final effectiveBorderRadius = BorderRadius.circular(borderRadius ?? 12);
    final effectiveTextStyle = _getTextStyle(theme);

    Widget buttonChild = loading
        ? SizedBox(
            height: effectiveTextStyle.fontSize,
            width: effectiveTextStyle.fontSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: effectiveTextStyle.fontSize! * 1.2,
                  color: foregroundColor,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: effectiveTextStyle.copyWith(color: foregroundColor),
                textAlign: TextAlign.center,
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                trailingIcon!,
              ],
            ],
          );

    if (expanded) {
      buttonChild = Expanded(child: buttonChild);
    }

    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.danger:
      case ButtonVariant.success:
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: effectiveBorderRadius,
              side: borderColor != null
                  ? BorderSide(color: borderColor)
                  : BorderSide.none,
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: buttonChild,
        );

      case ButtonVariant.outline:
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: effectiveBorderRadius,
              side: BorderSide(
                color: borderColor ?? theme.colorScheme.outline,
                width: 1.5,
              ),
            ),
          ),
          child: buttonChild,
        );

      case ButtonVariant.text:
        return TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            padding: effectivePadding,
            shape: RoundedRectangleBorder(
              borderRadius: effectiveBorderRadius,
            ),
          ),
          child: buttonChild,
        );
    }
  }

  Color _getBackgroundColor(ThemeData theme, bool isDisabled) {
    if (isDisabled) {
      return theme.disabledColor.withOpacity(0.2);
    }

    if (customColor != null) {
      return customColor!;
    }

    switch (variant) {
      case ButtonVariant.primary:
        return theme.colorScheme.primary;
      case ButtonVariant.secondary:
        return theme.colorScheme.secondary;
      case ButtonVariant.danger:
        return theme.colorScheme.error;
      case ButtonVariant.success:
        return Colors.green;
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return Colors.transparent;
    }
  }

  Color _getForegroundColor(ThemeData theme, bool isDisabled) {
    if (isDisabled) {
      return theme.disabledColor;
    }

    if (customColor != null && variant == ButtonVariant.primary) {
      return theme.colorScheme.onPrimary;
    }

    switch (variant) {
      case ButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case ButtonVariant.secondary:
        return theme.colorScheme.onSecondary;
      case ButtonVariant.danger:
        return theme.colorScheme.onError;
      case ButtonVariant.success:
        return Colors.white;
      case ButtonVariant.outline:
      case ButtonVariant.text:
        return customColor ?? theme.colorScheme.primary;
    }
  }

  Color? _getBorderColor(ThemeData theme, bool isDisabled) {
    if (isDisabled) {
      return theme.disabledColor;
    }

    if (variant == ButtonVariant.outline) {
      return customColor ?? theme.colorScheme.primary;
    }

    return null;
  }

  EdgeInsets _getPadding() {
    if (padding != null) return padding!;

    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  TextStyle _getTextStyle(ThemeData theme) {
    if (textStyle != null) return textStyle!;

    switch (size) {
      case ButtonSize.small:
        return theme.textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.medium:
        return theme.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w600,
        );
      case ButtonSize.large:
        return theme.textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w600,
        );
    }
  }
}