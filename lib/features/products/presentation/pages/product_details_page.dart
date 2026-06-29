import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    @PathParam('id') required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Product Details',
      subtitle: 'Product ID: $id',
      child: ElevatedButton(
        onPressed: () => context.router.push(const CheckoutRoute()),
        child: const Text('Buy Now'),
      ),
    );
  }
}
