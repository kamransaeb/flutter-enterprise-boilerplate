import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldVariant {
  outlined,
  filled,
  underline,
}

enum TextFieldSize {
  small,
  medium,
  large,
}

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextFieldVariant variant;
  final TextFieldSize size;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autoFocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool showCounter;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final bool expands;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final AutovalidateMode? autovalidateMode;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;

  const AppTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffixIcon,
    this.variant = TextFieldVariant.outlined,
    this.size = TextFieldSize.medium,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autoFocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.focusNode,
    this.showCounter = false,
    this.contentPadding,
    this.borderRadius,
    this.fillColor,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.expands = false,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autovalidateMode,
    this.autocorrect = true,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: _buildDecoration(theme),
      style: widget.style ?? theme.textTheme.bodyMedium,
      obscureText: _obscureText,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      autofocus: widget.autoFocus,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.obscureText ? 1 : widget.minLines,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onEditingComplete: widget.onEditingComplete,
      onTap: widget.onTap,
      expands: widget.expands,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      autovalidateMode: widget.autovalidateMode,
      autocorrect: widget.autocorrect,
      smartDashesType: widget.smartDashesType,
      smartQuotesType: widget.smartQuotesType,
      enableSuggestions: widget.enableSuggestions,
    );
  }

  InputDecoration _buildDecoration(ThemeData theme) {
    final effectivePadding = _getContentPadding();
    final effectiveBorderRadius = BorderRadius.circular(
      widget.borderRadius ?? 12,
    );

    InputDecoration baseDecoration;

    switch (widget.variant) {
      case TextFieldVariant.outlined:
        baseDecoration = InputDecoration(
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          filled: false,
        );
        break;

      case TextFieldVariant.filled:
        baseDecoration = InputDecoration(
          border: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: effectiveBorderRadius,
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: widget.fillColor ?? theme.colorScheme.surfaceVariant,
        );
        break;

      case TextFieldVariant.underline:
        baseDecoration = InputDecoration(
          border: const UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.error,
              width: 2,
            ),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.3),
            ),
          ),
          filled: false,
        );
        break;
    }

    Widget? effectiveSuffixIcon = widget.suffixIcon;
    if (widget.obscureText) {
      effectiveSuffixIcon = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    return baseDecoration.copyWith(
      labelText: widget.labelText,
      hintText: widget.hintText,
      errorText: widget.errorText,
      helperText: widget.helperText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: effectiveSuffixIcon,
      contentPadding: effectivePadding,
      labelStyle: widget.labelStyle,
      hintStyle: widget.hintStyle ?? theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onSurfaceVariant,
      ),
      errorStyle: widget.errorStyle ?? theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.error,
      ),
      counterText: widget.showCounter ? null : '',
      alignLabelWithHint: true,
    );
  }

  EdgeInsetsGeometry _getContentPadding() {
    if (widget.contentPadding != null) return widget.contentPadding!;

    switch (widget.size) {
      case TextFieldSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
      case TextFieldSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 14);
      case TextFieldSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 18);
    }
  }
}