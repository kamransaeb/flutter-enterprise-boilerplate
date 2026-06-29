import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class ForbiddenPage extends StatelessWidget {
  const ForbiddenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: '403',
      subtitle: 'You do not have permission to access this page',
      child: ElevatedButton(
        onPressed: () => context.router.replace(const HomeRoute()),
        child: const Text('Go Home'),
      ),
    );
  }
}
