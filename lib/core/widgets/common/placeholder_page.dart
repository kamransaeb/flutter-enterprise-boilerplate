import 'package:flutter/material.dart';

/// Simple scaffold used for boilerplate pages until feature UI is built.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({
    required this.title,
    super.key,
    this.subtitle,
    this.child,
  });

  final String title;
  final String? subtitle;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 12),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
              if (child != null) ...[
                const SizedBox(height: 24),
                child!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
