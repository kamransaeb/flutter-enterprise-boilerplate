import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/core/errors/failures.dart';
import '../../../../lib/features/products/domain/entities/product.dart';
import '../../../../lib/features/products/domain/repositories/product_repository.dart';
import '../../../../lib/features/products/domain/usecases/get_products_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late GetProductsUseCase useCase;
  late MockProductRepository mockRepository;

  setUp(() {
    mockRepository = MockProductRepository();
    useCase = GetProductsUseCase(mockRepository);
  });

  const tPage = 1;
  const tLimit = 20;
  final tProducts = [
    Product.empty().copyWith(id: '1', name: 'Product 1'),
    Product.empty().copyWith(id: '2', name: 'Product 2'),
  ];

  group('GetProductsUseCase', () {
    test('should get products from the repository', () async {
      // Arrange
      when(() => mockRepository.getProducts(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        filter: any(named: 'filter'),
      )).thenAnswer((_) async => Right(tProducts));

      // Act
      final result = await useCase.execute(
        const GetProductsParams(page: tPage, limit: tLimit),
      );

      // Assert
      expect(result, Right(tProducts));
      verify(() => mockRepository.getProducts(
        page: tPage,
        limit: tLimit,
        filter: null,
      )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository fails', () async {
      // Arrange
      final tFailure = ServerFailure('Server error');
      when(() => mockRepository.getProducts(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        filter: any(named: 'filter'),
      )).thenAnswer((_) async => Left(tFailure));

      // Act
      final result = await useCase.execute(
        const GetProductsParams(page: tPage, limit: tLimit),
      );

      // Assert
      expect(result, Left(tFailure));
      verify(() => mockRepository.getProducts(
        page: tPage,
        limit: tLimit,
        filter: null,
      )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should pass filter to repository when provided', () async {
      // Arrange
      final tFilter = ProductFilter(
        categories: ['electronics'],
        minPrice: 100,
        maxPrice: 1000,
      );
      
      when(() => mockRepository.getProducts(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        filter: any(named: 'filter'),
      )).thenAnswer((_) async => Right(tProducts));

      // Act
      final result = await useCase.execute(
        GetProductsParams(
          page: tPage,
          limit: tLimit,
          filter: tFilter,
        ),
      );

      // Assert
      expect(result, Right(tProducts));
      verify(() => mockRepository.getProducts(
        page: tPage,
        limit: tLimit,
        filter: tFilter,
      )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle empty product list', () async {
      // Arrange
      when(() => mockRepository.getProducts(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        filter: any(named: 'filter'),
      )).thenAnswer((_) async => const Right([]));

      // Act
      final result = await useCase.execute(
        const GetProductsParams(page: tPage, limit: tLimit),
      );

      // Assert
      expect(result, const Right([]));
      verify(() => mockRepository.getProducts(
        page: tPage,
        limit: tLimit,
        filter: null,
      )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle different page and limit values', () async {
      // Arrange
      const tPage2 = 2;
      const tLimit50 = 50;
      
      when(() => mockRepository.getProducts(
        page: any(named: 'page'),
        limit: any(named: 'limit'),
        filter: any(named: 'filter'),
      )).thenAnswer((_) async => Right(tProducts));

      // Act
      final result = await useCase.execute(
        const GetProductsParams(page: tPage2, limit: tLimit50),
      );

      // Assert
      expect(result, Right(tProducts));
      verify(() => mockRepository.getProducts(
        page: tPage2,
        limit: tLimit50,
        filter: null,
      )).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}