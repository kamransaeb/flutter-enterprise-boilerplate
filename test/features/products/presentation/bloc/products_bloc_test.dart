import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/core/errors/failures.dart';
import '../../../../lib/features/products/domain/entities/product.dart';
import '../../../../lib/features/products/domain/usecases/get_products_usecase.dart';
import '../../../../lib/features/products/domain/usecases/search_products_usecase.dart';
import '../../../../lib/features/products/domain/usecases/toggle_favorite_usecase.dart';
import '../../../../lib/features/products/presentation/bloc/products_bloc.dart';

class MockGetProductsUseCase extends Mock implements GetProductsUseCase {}
class MockSearchProductsUseCase extends Mock implements SearchProductsUseCase {}
class MockToggleFavoriteUseCase extends Mock implements ToggleFavoriteUseCase {}

void main() {
  late ProductsBloc productsBloc;
  late MockGetProductsUseCase mockGetProductsUseCase;
  late MockSearchProductsUseCase mockSearchProductsUseCase;
  late MockToggleFavoriteUseCase mockToggleFavoriteUseCase;

  final tProducts = [
    Product.empty().copyWith(id: '1', name: 'Product 1'),
    Product.empty().copyWith(id: '2', name: 'Product 2'),
  ];

  setUp(() {
    mockGetProductsUseCase = MockGetProductsUseCase();
    mockSearchProductsUseCase = MockSearchProductsUseCase();
    mockToggleFavoriteUseCase = MockToggleFavoriteUseCase();
    
    productsBloc = ProductsBloc(
      mockGetProductsUseCase,
      mockSearchProductsUseCase,
      mockToggleFavoriteUseCase,
    );
  });

  tearDown(() {
    productsBloc.close();
  });

  group('ProductsBloc', () {
    test('initial state is ProductsState.initial()', () {
      expect(productsBloc.state, equals(const ProductsState.initial()));
    });

    blocTest<ProductsBloc, ProductsState>(
      'emits [loading, loaded] when fetchProducts is successful',
      build: () {
        when(() => mockGetProductsUseCase.execute(any()))
            .thenAnswer((_) async => Right(tProducts));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const ProductsEvent.fetchProducts()),
      expect: () => [
        const ProductsState.loading(),
        ProductsState.loaded(
          products: tProducts,
          hasMore: true,
          page: 1,
        ),
      ],
      verify: (_) {
        verify(() => mockGetProductsUseCase.execute(
          const GetProductsParams(page: 1),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [loading, error] when fetchProducts fails',
      build: () {
        when(() => mockGetProductsUseCase.execute(any()))
            .thenAnswer((_) async => Left(ServerFailure('Server error')));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const ProductsEvent.fetchProducts()),
      expect: () => [
        const ProductsState.loading(),
        ProductsState.error(ServerFailure('Server error')),
      ],
      verify: (_) {
        verify(() => mockGetProductsUseCase.execute(
          const GetProductsParams(page: 1),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [loading, loaded] when searchProducts is successful',
      build: () {
        when(() => mockSearchProductsUseCase.execute(any()))
            .thenAnswer((_) async => Right(tProducts));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const ProductsEvent.searchProducts('query')),
      expect: () => [
        const ProductsState.loading(),
        ProductsState.searchResults(products: tProducts),
      ],
      verify: (_) {
        verify(() => mockSearchProductsUseCase.execute(
          const SearchProductsParams(query: 'query'),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [loading, error] when searchProducts fails',
      build: () {
        when(() => mockSearchProductsUseCase.execute(any()))
            .thenAnswer((_) async => Left(ServerFailure('Search failed')));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const ProductsEvent.searchProducts('query')),
      expect: () => [
        const ProductsState.loading(),
        ProductsState.error(ServerFailure('Search failed')),
      ],
      verify: (_) {
        verify(() => mockSearchProductsUseCase.execute(
          const SearchProductsParams(query: 'query'),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'updates product favorite status when toggleFavorite is successful',
      build: () {
        when(() => mockToggleFavoriteUseCase.execute(any()))
            .thenAnswer((_) async => const Right(null));
        return productsBloc;
      },
      seed: () => ProductsState.loaded(
        products: tProducts,
        hasMore: false,
        page: 1,
      ),
      act: (bloc) => bloc.add(const ProductsEvent.toggleFavorite('1')),
      expect: () => [
        ProductsState.loaded(
          products: [
            tProducts[0].copyWith(isFavorite: true),
            tProducts[1],
          ],
          hasMore: false,
          page: 1,
        ),
      ],
      verify: (_) {
        verify(() => mockToggleFavoriteUseCase.execute(
          const ToggleFavoriteParams(productId: '1'),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [refreshing, loaded] when refreshProducts is successful',
      build: () {
        when(() => mockGetProductsUseCase.execute(any()))
            .thenAnswer((_) async => Right(tProducts));
        return productsBloc;
      },
      act: (bloc) => bloc.add(const ProductsEvent.refreshProducts()),
      expect: () => [
        const ProductsState.refreshing(),
        ProductsState.loaded(
          products: tProducts,
          hasMore: true,
          page: 1,
        ),
      ],
      verify: (_) {
        verify(() => mockGetProductsUseCase.execute(
          const GetProductsParams(page: 1),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'emits [loadingMore, loaded] when loadMoreProducts is successful',
      build: () {
        when(() => mockGetProductsUseCase.execute(any()))
            .thenAnswer((_) async => Right([Product.empty().copyWith(id: '3')]));
        return productsBloc;
      },
      seed: () => ProductsState.loaded(
        products: tProducts,
        hasMore: true,
        page: 1,
      ),
      act: (bloc) => bloc.add(const ProductsEvent.loadMoreProducts()),
      expect: () => [
        ProductsState.loadingMore(products: tProducts),
        ProductsState.loaded(
          products: [...tProducts, Product.empty().copyWith(id: '3')],
          hasMore: true,
          page: 2,
        ),
      ],
      verify: (_) {
        verify(() => mockGetProductsUseCase.execute(
          const GetProductsParams(page: 2),
        )).called(1);
      },
    );

    blocTest<ProductsBloc, ProductsState>(
      'does not load more when hasMore is false',
      build: () {
        return productsBloc;
      },
      seed: () => ProductsState.loaded(
        products: tProducts,
        hasMore: false,
        page: 1,
      ),
      act: (bloc) => bloc.add(const ProductsEvent.loadMoreProducts()),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockGetProductsUseCase.execute(any()));
      },
    );
  });
}