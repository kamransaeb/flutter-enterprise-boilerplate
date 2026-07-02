import 'package:bloc/bloc.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/usecases/search_product_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/toggle_wishlist_usecase.dart';

part 'products_bloc.freezed.dart';
part 'products_event.dart';
part 'product_state.dart';

@injectable
class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProductsUseCase _getProductsUseCase;
  final SearchProductsUseCase _searchProductsUseCase;
  final ToggleWishlistUseCase _toggleWishlistUseCase;

  ProductsBloc(
    this._getProductsUseCase,
    this._searchProductsUseCase,
    this._toggleWishlistUseCase,
  ) : super(const ProductsState.initial()) {
    on<_FetchProducts>(_onFetchProducts);
    on<_SearchProducts>(_onSearchProducts);
    on<_ToggleWishlist>(_onToggleWishlist);
    on<_LoadMoreProducts>(_onLoadMoreProducts);
    on<_RefreshProducts>(_onRefreshProducts);
    on<_ApplyFilter>(_onApplyFilter);
    on<_ClearFilter>(_onClearFilter);
  }

  Future<void> _onFetchProducts(
    _FetchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    //if (state is ProductsStateLoading) return;

    emit(const ProductsState.loading());

    final result = await _getProductsUseCase.execute(
      GetProductsParams(
        page: event.page,
        filter: event.filter,
      ),  
    );

    result.fold(
      (failure) => emit(ProductsState.error(failure)),
      (products) => emit(
        ProductsState.loaded(
          products: products,
          hasMore: products.length >= 20, // Assuming 20 per page
          page: event.page,
        ),
      ),
    );
  }

  Future<void> _onSearchProducts(
    _SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.loading());

    final result = await _searchProductsUseCase.execute(
      SearchProductsParams(query: event.query),
    );

    result.fold(
      (failure) => emit(ProductsState.error(failure)),
      (products) => emit(
        ProductsState.loaded(
          products: products,
          hasMore: false,
          page: 1,
        ),
      ),
    );
  }

  Future<void> _onToggleWishlist(
    _ToggleWishlist event,
    Emitter<ProductsState> emit,
  ) async {
    final result = await _toggleWishlistUseCase.execute(
      ToggleWishlistParams(productId: event.productId),
    );

    result.fold(
      (failure) => emit(ProductsState.error(failure)),
      (_) {
        // Update the product in the current state
        state.maybeWhen(
          loaded: (products, hasMore, page) {
            final updatedProducts = products.map((product) {
              if (product.id == event.productId) {
                return product.copyWith(
                  isFavorite: !product.isFavorite,
                );
              }
              return product;
            }).toList();

            emit(
              ProductsState.loaded(
                products: updatedProducts,
                hasMore: hasMore,
                page: page,
              ),
            );
          },
          orElse: () {},
        );
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    _LoadMoreProducts event,
    Emitter<ProductsState> emit,
  ) async {
    state.maybeWhen(
      loaded: (products, hasMore, page) async {
        if (!hasMore) return;

        emit(ProductsState.loadingMore(products: products));

        final result = await _getProductsUseCase.execute(
          GetProductsParams(page: page + 1),
        );

        result.fold(
          (failure) => emit(ProductsState.error(failure)),
          (newProducts) => emit(
            ProductsState.loaded(
              products: [...products, ...newProducts],
              hasMore: newProducts.length >= 20,
              page: page + 1,
            ),
          ),
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onRefreshProducts(
    _RefreshProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.refreshing());

    final result = await _getProductsUseCase.execute(
      GetProductsParams(page: 1),
    );

    result.fold(
      (failure) => emit(ProductsState.error(failure)),
      (products) => emit(
        ProductsState.loaded(
          products: products,
          hasMore: products.length >= 20,
          page: 1,
        ),
      ),
    );
  }

  Future<void> _onApplyFilter(
    _ApplyFilter event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.loading());

    final result = await _getProductsUseCase.execute(
      GetProductsParams(
        page: 1,
        filter: event.filter,
      ),
    );

    result.fold(
      (failure) => emit(ProductsState.error(failure)),
      (products) => emit(
        ProductsState.loaded(
          products: products,
          hasMore: products.length >= 20,
          page: 1,
        ),
      ),
    );
  }

  Future<void> _onClearFilter(
    _ClearFilter event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsState.loading());

    final result = await _getProductsUseCase.execute(
      GetProductsParams(page: 1),
    );

    result.fold(
      (failure) => emit(ProductsState.error(failure)),
      (products) => emit(
        ProductsState.loaded(
          products: products,
          hasMore: products.length >= 20,
          page: 1,
        ),
      ),
    );
  }
}