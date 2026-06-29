import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: '404',
      subtitle: 'Page not found',
      child: ElevatedButton(
        onPressed: () => context.router.replace(const HomeRoute()),
        child: const Text('Go Home'),
      ),
    );
  }
}
