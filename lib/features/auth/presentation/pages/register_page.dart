import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Register',
      subtitle: 'Create a new account',
      child: TextButton(
        onPressed: () => context.router.replace(LoginRoute()),
        child: const Text('Already have an account? Sign in'),
      ),
    );
  }
}
