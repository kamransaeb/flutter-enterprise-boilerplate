import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex(context),
            onDestinationSelected: (index) => _onDestinationSelected(context, index),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Account'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications_outlined),
                selectedIcon: Icon(Icons.notifications),
                label: Text('Notifications'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.privacy_tip_outlined),
                selectedIcon: Icon(Icons.privacy_tip),
                label: Text('Privacy'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          const Expanded(child: AutoRouter()),
        ],
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final path = context.router.currentPath;
    if (path.contains('/notifications')) return 1;
    if (path.contains('/privacy')) return 2;
    return 0;
  }

  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.router.navigate(const AccountSettingsRoute());
      case 1:
        context.router.navigate(const NotificationSettingsRoute());
      case 2:
        context.router.navigate(const PrivacySettingsRoute());
    }
  }
}
