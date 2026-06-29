import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Forgot Password',
      subtitle: 'Enter your email to reset your password',
      child: TextButton(
        onPressed: () => context.router.maybePop(),
        child: const Text('Back to login'),
      ),
    );
  }
}
