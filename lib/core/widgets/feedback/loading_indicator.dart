import 'package:flutter/material.dart';

enum LoadingIndicatorSize {
  small,
  medium,
  large,
}

enum LoadingIndicatorType {
  circular,
  linear,
}

class LoadingIndicator extends StatelessWidget {
  final LoadingIndicatorSize size;
  final LoadingIndicatorType type;
  final Color? color;
  final double? strokeWidth;
  final String? message;
  final EdgeInsetsGeometry padding;

  const LoadingIndicator({
    super.key,
    this.size = LoadingIndicatorSize.medium,
    this.type = LoadingIndicatorType.circular,
    this.color,
    this.strokeWidth,
    this.message,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;
    final effectiveStrokeWidth = strokeWidth ?? _getStrokeWidth();

    if (type == LoadingIndicatorType.linear) {
      return _buildLinearIndicator(context, effectiveColor, effectiveStrokeWidth);
    }

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: _getSize(),
            height: _getSize(),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
              strokeWidth: effectiveStrokeWidth,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinearIndicator(
    BuildContext context,
    Color color,
    double strokeWidth,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: strokeWidth,
          ),
          if (message != null) ...[
            const SizedBox(height: 8),
            Text(
              message!,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  double _getSize() {
    switch (size) {
      case LoadingIndicatorSize.small:
        return 20;
      case LoadingIndicatorSize.medium:
        return 32;
      case LoadingIndicatorSize.large:
        return 48;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case LoadingIndicatorSize.small:
        return 2;
      case LoadingIndicatorSize.medium:
        return 3;
      case LoadingIndicatorSize.large:
        return 4;
    }
  }
}

class FullScreenLoading extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;
  final bool showLoading;

  const FullScreenLoading({
    super.key,
    this.message,
    this.backgroundColor,
    this.showLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showLoading)
                const LoadingIndicator(
                  size: LoadingIndicatorSize.large,
                ),
              if (message != null) ...[
                if (showLoading) const SizedBox(height: 16),
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
}