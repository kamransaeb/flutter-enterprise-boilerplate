import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Profile',
      subtitle: 'Manage your account',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => context.router.push(const SettingsRoute()),
            child: const Text('Settings'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => context.router.push(const OrdersRoute()),
            child: const Text('My Orders'),
          ),
        ],
      ),
    );
  }
}
