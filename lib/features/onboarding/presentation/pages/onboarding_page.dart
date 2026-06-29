import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Onboarding',
      subtitle: 'Get started with the app',
      child: ElevatedButton(
        onPressed: () => context.router.replace(LoginRoute()),
        child: const Text('Get Started'),
      ),
    );
  }
}
