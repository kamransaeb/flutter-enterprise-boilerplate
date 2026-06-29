import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Reset Password',
      subtitle: 'Choose a new password',
      child: TextButton(
        onPressed: () => context.router.replace(LoginRoute()),
        child: const Text('Back to login'),
      ),
    );
  }
}
