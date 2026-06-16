import 'package:flutter/material.dart';

enum DialogType {
  info,
  success,
  warning,
  error,
  confirm,
  custom,
}

class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final DialogType type;
  final Widget? icon;
  final List<Widget>? actions;
  final bool showCloseButton;
  final bool barrierDismissible;
  final VoidCallback? onClose;
  final EdgeInsetsGeometry contentPadding;
  final double? maxWidth;
  final bool showDivider;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? messageColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxConstraints? constraints;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    this.type = DialogType.info,
    this.icon,
    this.actions,
    this.showCloseButton = true,
    this.barrierDismissible = true,
    this.onClose,
    this.contentPadding = const EdgeInsets.all(24),
    this.maxWidth = 400,
    this.showDivider = true,
    this.backgroundColor,
    this.titleColor,
    this.messageColor,
    this.borderRadius,
    this.constraints,
  });

  factory AppDialog.info({
    required String title,
    required String message,
    Widget? icon,
    List<Widget>? actions,
    bool showCloseButton = true,
  }) {
    return AppDialog(
      title: title,
      message: message,
      type: DialogType.info,
      icon: icon ?? const Icon(Icons.info_outline, size: 48),
      actions: actions,
      showCloseButton: showCloseButton,
    );
  }

  factory AppDialog.success({
    required String title,
    required String message,
    Widget? icon,
    List<Widget>? actions,
    bool showCloseButton = true,
  }) {
    return AppDialog(
      title: title,
      message: message,
      type: DialogType.success,
      icon: icon ?? const Icon(Icons.check_circle_outline, size: 48, color: Colors.green),
      actions: actions,
      showCloseButton: showCloseButton,
    );
  }

  factory AppDialog.warning({
    required String title,
    required String message,
    Widget? icon,
    List<Widget>? actions,
    bool showCloseButton = true,
  }) {
    return AppDialog(
      title: title,
      message: message,
      type: DialogType.warning,
      icon: icon ?? const Icon(Icons.warning_amber_outlined, size: 48, color: Colors.orange),
      actions: actions,
      showCloseButton: showCloseButton,
    );
  }

  factory AppDialog.error({
    required String title,
    required String message,
    Widget? icon,
    List<Widget>? actions,
    bool showCloseButton = true,
  }) {
    return AppDialog(
      title: title,
      message: message,
      type: DialogType.error,
      icon: icon ?? const Icon(Icons.error_outline, size: 48, color: Colors.red),
      actions: actions,
      showCloseButton: showCloseButton,
    );
  }

  factory AppDialog.confirm({
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool destructive = false,
    Widget? icon,
  }) {
    return AppDialog(
      title: title,
      message: message,
      type: DialogType.confirm,
      icon: icon,
      actions: [
        TextButton(
          onPressed: onCancel ?? () {},
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          style: destructive
              ? ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                )
              : null,
          child: Text(confirmText),
        ),
      ],
    );
  }

  Color _getColorByType(BuildContext context) {
    final theme = Theme.of(context);
    
    switch (type) {
      case DialogType.info:
        return theme.colorScheme.primary;
      case DialogType.success:
        return Colors.green;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.error:
        return theme.colorScheme.error;
      case DialogType.confirm:
        return theme.colorScheme.primary;
      case DialogType.custom:
        return theme.colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dialogColor = _getColorByType(context);
    
    return Dialog(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: constraints ??
            BoxConstraints(
              maxWidth: maxWidth!,
              minWidth: 280,
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    IconTheme(
                      data: IconThemeData(
                        color: dialogColor,
                        size: 48,
                      ),
                      child: icon!,
                    ),
                    const SizedBox(width: 16),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: titleColor ?? theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: messageColor ?? theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (showCloseButton)
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onClose?.call();
                      },
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                ],
              ),
            ),
            
            // Divider
            if (showDivider)
              const Divider(height: 1),
            
            // Actions
            if (actions != null && actions!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget dialog,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
  }) async {
    return await showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      barrierLabel: barrierLabel,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      builder: (context) => dialog,
    );
  }

  static Future<bool> showConfirm({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool destructive = false,
    Widget? icon,
    bool barrierDismissible = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog.confirm(
        title: title,
        message: message,
        onConfirm: () => Navigator.of(context).pop(true),
        onCancel: () => Navigator.of(context).pop(false),
        confirmText: confirmText,
        cancelText: cancelText,
        destructive: destructive,
        icon: icon,
      ),
    );
    
    return result ?? false;
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    Widget? icon,
    String buttonText = 'OK',
    VoidCallback? onClose,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog.info(
        title: title,
        message: message,
        icon: icon,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClose?.call();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    Widget? icon,
    String buttonText = 'OK',
    VoidCallback? onClose,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog.success(
        title: title,
        message: message,
        icon: icon,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClose?.call();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    Widget? icon,
    String buttonText = 'OK',
    VoidCallback? onClose,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog.error(
        title: title,
        message: message,
        icon: icon,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClose?.call();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }

  static Future<void> showWarning({
    required BuildContext context,
    required String title,
    required String message,
    Widget? icon,
    String buttonText = 'OK',
    VoidCallback? onClose,
    bool barrierDismissible = true,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AppDialog.warning(
        title: title,
        message: message,
        icon: icon,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onClose?.call();
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final bool barrierDismissible;
  final Color? barrierColor;
  final bool showCloseButton;

  const LoadingDialog({
    super.key,
    this.title,
    this.message,
    this.barrierDismissible = false,
    this.barrierColor,
    this.showCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => barrierDismissible,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(40),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCloseButton)
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              const CircularProgressIndicator(),
              if (title != null) ...[
                const SizedBox(height: 16),
                Text(
                  title!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(
                  message!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    String? title,
    String? message,
    bool barrierDismissible = false,
    Color? barrierColor,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (context) => LoadingDialog(
        title: title,
        message: message,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class BottomSheetDialog extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showDivider;
  final bool showCloseButton;
  final bool isScrollControlled;
  final bool useRootNavigator;
  final bool isDismissible;
  final bool enableDrag;
  final Color? backgroundColor;
  final double? elevation;
  final ShapeBorder? shape;
  final Clip? clipBehavior;
  final BoxConstraints? constraints;
  final Color? barrierColor;

  const BottomSheetDialog({
    super.key,
    required this.child,
    this.title,
    this.showDivider = true,
    this.showCloseButton = true,
    this.isScrollControlled = false,
    this.useRootNavigator = false,
    this.isDismissible = true,
    this.enableDrag = true,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior,
    this.constraints,
    this.barrierColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null || showCloseButton)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (showCloseButton)
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 40,
                        minHeight: 40,
                      ),
                    ),
                ],
              ),
            ),
          if (showDivider && (title != null || showCloseButton))
            const Divider(height: 1),
          child,
        ],
      ),
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showDivider = true,
    bool showCloseButton = true,
    bool isScrollControlled = false,
    bool useRootNavigator = false,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    Clip? clipBehavior,
    BoxConstraints? constraints,
    Color? barrierColor,
  }) async {
    return await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape ??
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
      clipBehavior: clipBehavior,
      constraints: constraints,
      barrierColor: barrierColor,
      builder: (context) => BottomSheetDialog(
        child: child,
        title: title,
        showDivider: showDivider,
        showCloseButton: showCloseButton,
        isScrollControlled: isScrollControlled,
        useRootNavigator: useRootNavigator,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        backgroundColor: backgroundColor,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        constraints: constraints,
        barrierColor: barrierColor,
      ),
    );
  }
}