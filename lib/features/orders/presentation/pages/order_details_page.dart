import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({
    @PathParam('id') required this.id,
    super.key,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(
      title: 'Order Details',
      subtitle: 'Order ID: $id',
    );
  }
}
