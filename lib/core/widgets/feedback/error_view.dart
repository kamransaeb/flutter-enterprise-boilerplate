import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String title;
  final String message;
  final String? retryText;
  final VoidCallback? onRetry;
  final Widget? icon;
  final EdgeInsetsGeometry padding;

  const ErrorView({
    super.key,
    required this.title,
    required this.message,
    this.retryText,
    this.onRetry,
    this.icon,
    this.padding = const EdgeInsets.all(16),
  });

  factory ErrorView.network({
    VoidCallback? onRetry,
    String? retryText,
  }) {
    return ErrorView(
      title: 'Connection Error',
      message: 'Please check your internet connection and try again.',
      retryText: retryText ?? 'Retry',
      onRetry: onRetry,
      icon: const Icon(
        Icons.wifi_off,
        size: 64,
      ),
    );
  }

  factory ErrorView.generic({
    String? title,
    String? message,
    VoidCallback? onRetry,
  }) {
    return ErrorView(
      title: title ?? 'Something went wrong',
      message: message ?? 'Please try again later.',
      retryText: 'Try Again',
      onRetry: onRetry,
      icon: const Icon(
        Icons.error_outline,
        size: 64,
      ),
    );
  }

  factory ErrorView.empty({
    String? title,
    String? message,
    VoidCallback? onRetry,
  }) {
    return ErrorView(
      title: title ?? 'No data found',
      message: message ?? 'There is nothing to display here.',
      retryText: 'Refresh',
      onRetry: onRetry,
      icon: const Icon(
        Icons.search_off,
        size: 64,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  size: 64,
                  color: theme.colorScheme.error,
                ),
                child: icon!,
              ),
              const SizedBox(height: 24),
            ],
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryText ?? 'Retry'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}