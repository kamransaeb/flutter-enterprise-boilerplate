part of 'products_bloc.dart';

@freezed
abstract class ProductsEvent with _$ProductsEvent {
  const factory ProductsEvent.fetchProducts({
    @Default(1) int page,
    ProductFilter? filter,
  }) = _FetchProducts;

  const factory ProductsEvent.searchProducts(String query) = _SearchProducts;

  const factory ProductsEvent.toggleWishlist(String productId) = _ToggleWishlist;

  const factory ProductsEvent.loadMoreProducts() = _LoadMoreProducts;

  const factory ProductsEvent.refreshProducts() = _RefreshProducts;

  const factory ProductsEvent.applyFilter(ProductFilter filter) = _ApplyFilter;

  const factory ProductsEvent.clearFilter() = _ClearFilter;
}