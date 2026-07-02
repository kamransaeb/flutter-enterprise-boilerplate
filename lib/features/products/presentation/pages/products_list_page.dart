import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
// import 'package:infinite_scroll_pagination/.dart';

import '../../../../core/navigation/app_router.dart';
import '../../../../core/widgets/common/app_button.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/feedback/error_view.dart';
import '../../../../core/widgets/feedback/loading_indicator.dart';
import '../../domain/entities/product.dart';
import '../bloc/products_bloc.dart';
import '../widgets/product_card.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  static const _pageSize = 20;
  // late final PagingController<int, Product> _pagingController;
  final TextEditingController _searchController = TextEditingController();
  late ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();
    _productsBloc = context.read<ProductsBloc>();
    // _pagingController = PagingController<int, Product>(
    //   getNextPageKey: (state) {
    //     final lastPage = state.pages?.lastOrNull;
    //     if (lastPage != null && lastPage.length < _pageSize) {
    //       return null;
    //     }
    //     if (state.lastPageIsEmpty) {
    //       return null;
    //     }
    //     return state.nextIntPageKey;
    //   },
    //   fetchPage: _fetchPage,
    // );
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // _pagingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Product>> _fetchPage(int pageKey) async {
    final query = _searchController.text.trim();

    if (query.isNotEmpty) {
      // search is single-page
      if (pageKey > 1) {
        return [];
      }
      _productsBloc.add(ProductsEvent.searchProducts(query));
    } else {
      _productsBloc.add(ProductsEvent.fetchProducts(page: pageKey));
    }

    final blocState = await _productsBloc.stream.firstWhere(
      (state) => state.maybeWhen(
        loaded: (_, __, ___) => true,
        error: (_) => true,
        orElse: () => false,
      ),
    );

    return blocState.maybeWhen(
      loaded: (products, _, __) => products,
      error: (failure) => throw Exception(failure.message),
      orElse: () => throw StateError('Unexpected products state'),
    );
  }

  void _onSearchChanged() {
    setState(() {});
    // _pagingController.refresh();
  }

  String _errorMessage(Object? error) {
    if (error is Failure) {
      return error.message;
    }
    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }
    return 'Something went wrong';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilters,
          ),
          IconButton(icon: const Icon(Icons.sort), onPressed: _showSortOptions),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppTextField(
              controller: _searchController,
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _searchController.clear,
                    )
                  : null,
            ),
          ),



          // Expanded(
          //   child: RefreshIndicator(
          //     onRefresh: () async => _pagingController.refresh(),
          //     child: PagingListener(
          //       controller: _pagingController,
          //       builder: (context, state, fetchNextPage) =>
          //           PagedListView<int, Product>.separated(
          //         state: state,
          //         fetchNextPage: fetchNextPage,
          //         builderDelegate: PagedChildBuilderDelegate<Product>(
          //           itemBuilder: (context, product, index) => ProductCard(
          //             product: product,
          //             onTap: () {
          //               context.router.push(
          //                 ProductDetailsRoute(id: product.id),
          //               );
          //             },
          //             onAddToCart: () => _addToCart(product),
          //             onFavorite: () => _toggleWishlist(product),
          //           ),
          //           firstPageProgressIndicatorBuilder: (_) =>
          //               const LoadingIndicator(),
          //           newPageProgressIndicatorBuilder: (_) =>
          //               const LoadingIndicator(),
          //           firstPageErrorIndicatorBuilder: (_) => ErrorView.generic(
          //             message: _errorMessage(state.error),
          //             onRetry: _pagingController.fetchNextPage,
          //           ),
          //           newPageErrorIndicatorBuilder: (_) => ErrorView.generic(
          //             message: _errorMessage(state.error),
          //             onRetry: _pagingController.fetchNextPage,
          //           ),
          //           noItemsFoundIndicatorBuilder: (_) => ErrorView.empty(
          //             message: 'No products found',
          //           ),
          //           noMoreItemsIndicatorBuilder: (_) => const Padding(
          //             padding: EdgeInsets.all(16),
          //             child: Text('No more products'),
          //           ),
          //         ),
          //         separatorBuilder: (_, __) => const SizedBox(height: 12),
          //       ),
          //     ),
          //   ),
          // ),



        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const NewProductRoute());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const SortBottomSheet(),
    );
  }

  void _addToCart(Product product) {
    // Implement add to cart logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${product.name} added to cart')));
  }

  void _toggleWishlist(Product product) {
    _productsBloc.add(ProductsEvent.toggleWishlist(product.id));
    // _pagingController.mapItems((item) {
    //   if (item.id == product.id) {
    //     return item.copyWith(isFavorite: !item.isFavorite);
    //   }
    //   return item;
    // });
  }
}

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> _selectedCategories = [];
  double _minPrice = 0;
  double _maxPrice = 1000;
  bool _inStockOnly = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filters',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Price range
          const Text(
            'Price Range',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 5000,
            divisions: 50,
            labels: RangeLabels('\$$_minPrice', '\$$_maxPrice'),
            onChanged: (values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
          ),

          // Categories
          const SizedBox(height: 16),
          const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ['Electronics', 'Clothing', 'Home', 'Books', 'Sports']
                .map(
                  (category) => FilterChip(
                    label: Text(category),
                    selected: _selectedCategories.contains(category),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedCategories.add(category);
                        } else {
                          _selectedCategories.remove(category);
                        }
                      });
                    },
                  ),
                )
                .toList(),
          ),

          // In stock only
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _inStockOnly,
                onChanged: (value) {
                  setState(() {
                    _inStockOnly = value ?? false;
                  });
                },
              ),
              const Text('In stock only'),
            ],
          ),

          // Buttons
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCategories.clear();
                      _minPrice = 0;
                      _maxPrice = 1000;
                      _inStockOnly = false;
                    });
                  },
                  child: const Text('Clear All'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppButton(
                  text: 'Apply Filters',
                  onPressed: () {
                    Navigator.pop(context);
                    // Apply filters
                  },
                  variant: ButtonVariant.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort By',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          ...[
                ('Price: Low to High', Icons.arrow_upward),
                ('Price: High to Low', Icons.arrow_downward),
                ('Newest First', Icons.new_releases),
                ('Best Selling', Icons.star),
                ('Customer Rating', Icons.thumb_up),
              ]
              .map(
                (option) => ListTile(
                  leading: Icon(option.$2),
                  title: Text(option.$1),
                  onTap: () {
                    Navigator.pop(context);
                    // Apply sort
                  },
                ),
              )
              .toList(),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
