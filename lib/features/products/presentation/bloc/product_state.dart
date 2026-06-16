part of 'products_bloc.dart';

@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;

  const factory ProductsState.loading() = _Loading;

  const factory ProductsState.loadingMore({
    required List<Product> products,
  }) = _LoadingMore;

  const factory ProductsState.refreshing() = _Refreshing;

  const factory ProductsState.loaded({
    required List<Product> products,
    required bool hasMore,
    required int page,
  }) = _Loaded;

  const factory ProductsState.searchResults({
    required List<Product> products,
  }) = _SearchResults;

  const factory ProductsState.error(Failure failure) = _Error;

  const factory ProductsState.empty() = _Empty;
}