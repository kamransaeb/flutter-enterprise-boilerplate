import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Splash',
      subtitle: 'Loading...',
      child: ElevatedButton(
        onPressed: () => context.router.replace(const OnboardingRoute()),
        child: const Text('Continue'),
      ),
    );
  }
}
