import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class VerifyEmailPage extends StatelessWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Verify Email',
      subtitle: 'Check your inbox for a verification link',
      child: TextButton(
        onPressed: () => context.router.replace(const HomeRoute()),
        child: const Text('Continue'),
      ),
    );
  }
}
