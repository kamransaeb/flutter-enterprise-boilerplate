import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/common/placeholder_page.dart';

@RoutePage()
class NewProductPage extends StatelessWidget {
  const NewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderPage(
      title: 'New Product',
      subtitle: 'Add a new product to the catalog',
    );
  }
}
