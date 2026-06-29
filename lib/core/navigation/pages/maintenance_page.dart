import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'Maintenance',
      subtitle: 'The app is temporarily unavailable. Please try again later.',
    );
  }
}
