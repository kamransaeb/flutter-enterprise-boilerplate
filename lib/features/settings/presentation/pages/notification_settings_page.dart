import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Notification Settings',
      subtitle: 'Manage push and email notifications',
    );
  }
}
