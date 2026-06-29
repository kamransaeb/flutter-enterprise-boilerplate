import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class PrivacySettingsPage extends StatelessWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Privacy Settings',
      subtitle: 'Control your data and privacy preferences',
    );
  }
}
