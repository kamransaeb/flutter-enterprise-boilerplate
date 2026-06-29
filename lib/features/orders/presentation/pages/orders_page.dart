import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Orders',
      subtitle: 'View your order history',
      child: ElevatedButton(
        onPressed: () => context.router.push(OrderDetailsRoute(id: 'sample')),
        child: const Text('View Sample Order'),
      ),
    );
  }
}
