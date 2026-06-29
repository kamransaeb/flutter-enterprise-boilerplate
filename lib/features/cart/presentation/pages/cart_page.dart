import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Cart',
      subtitle: 'Your shopping cart is empty',
      child: ElevatedButton(
        onPressed: () => context.router.push(const CheckoutRoute()),
        child: const Text('Go to Checkout'),
      ),
    );
  }
}
