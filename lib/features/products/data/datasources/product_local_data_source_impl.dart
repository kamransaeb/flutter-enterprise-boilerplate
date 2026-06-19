import 'dart:convert';

import 'package:flutter_enterprise_boilerplate/core/constants/storage_constants.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/exceptions/cache_exceptions.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/datasources/product_local_data_source.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_category_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/paginated_cache_response.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:injectable/injectable.dart';

// *** fvm dart analyze lib/something_file.dart
// Dart's analyzer: reads code and reports errors, warnings, and info lints.
// examples of what it catches:
// - Missing methods / wrong types
// - Undefined symbols (_productKeyPrefix, etc.)
// - Return type mismatches
// - Unused imports
// - Linter rules from analysis_options.yaml

// When adapters are the better choice than using JsonEncode/Decode
// - You read/write one type very often (e.g. thousands of products offline)
// - You care about binary size and speed (adapters are smaller/faster)
// - The model shape is stable and you'll maintain migrations
// - You use a typed box like Box<ProductModel> everywhere
@LazySingleton(as: ProductLocalDataSource)
class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  
  ProductLocalDataSourceImpl({
    @Named('hive_storage') required LocalStorage hiveStorage,
  }) : _hiveStorage = hiveStorage;

  final LocalStorage _hiveStorage;

  
 
  
  @override
  Future<void> cacheFeaturedProducts({required List<ProductModel> products, int limit = 10}) async {
    
    try {
      final key = _featuredProductsKey(limit: limit);
      final payload = {
        'products': products.map((e) => e.toJson()).toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };
      final json = jsonEncode(payload);
      await _hiveStorage.write(key, json, boxName: StorageConstants.productsBox);
    } catch (e, stackTrace) {
      _logAndRethrow('cacheFeaturedProducts', 'Failed to cache featured products', e, stackTrace);
    }
  }

  @override
  Future<List<ProductModel>> getCachedFeaturedProducts({int limit = 10}) async {
    // TODO: implement getCachedFeaturedProducts
    try {
      final key = _featuredProductsKey(limit: limit);
      final cached = await _hiveStorage.read<String>(
        key,
        boxName: StorageConstants.productsBox,
      );
      if (cached == null) return [];
      final map = jsonDecode(cached) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(map['cachedAt'] as String);
      if (_isExpired(cachedAt)) {
        await _hiveStorage.delete(key, boxName: StorageConstants.productsBox);
        return [];
      }
      final products = map['products'] as List<dynamic>;
      return products.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stackTrace) {
      _logAndRethrow('getCachedFeaturedProducts', 'Failed to get cached featured products', e, stackTrace);
    }
  }

   @override
  Future<void> cacheRelatedProducts({required String productId, required List<ProductModel> products}) async {
    try {
      final key = _relatedProductsKey(productId: productId);
      final payload = {
        'products': products.map((e) => e.toJson()).toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };
      final json = jsonEncode(payload);
      await _hiveStorage.write(key, json, boxName: StorageConstants.productsBox);
    } catch (e, stackTrace) {
      _logAndRethrow('cacheRelatedProducts', 'Failed to cache related products', e, stackTrace);
    }
  }
  
  @override
  Future<List<ProductModel>> getCachedRelatedProducts(String productId) async  {
    // TODO: implement getCachedRelatedProducts
    try {
      final key = _relatedProductsKey(productId: productId);
      final cached = await _hiveStorage.read<String>(
        key,
        boxName: StorageConstants.productsBox,
      );
      if (cached == null) return [];
      final map = jsonDecode(cached) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(map['cachedAt'] as String);
      if (_isExpired(cachedAt)) {
        await _hiveStorage.delete(key, boxName: StorageConstants.productsBox);
        return [];
      }
      final products = map['products'] as List<dynamic>;
      return products.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stackTrace) {
      _logAndRethrow('getCachedRelatedProducts', 'Failed to get cached related products', e, stackTrace);
    }
  }
  
 

  @override
  Future<void> cacheProducts({
    required List<ProductModel> products,
    required int page,
    required int limit,
    ProductFilter? filter,
  }) async {
    try {
      final key = _productPageKey(page: page, limit: limit, filter: filter);
      final payload = {
        'items': products.map((e) => e.toJson()).toList(),
        'page': page,
        'limit': limit,
        'cachedAt': DateTime.now().toIso8601String(),
        'hasMore': products.length >= limit,
      };
      await _hiveStorage.write(
        key,
        jsonEncode(payload),
        boxName: StorageConstants.productsBox,
      );
      await cacheMultipleProducts(products);
    } catch (e, stackTrace) {
      _logAndRethrow(
        'cacheProducts',
        'Failed to cache products',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<PaginatedCacheResponse<ProductModel>?> getCachedProducts({
    required int page,
    required int limit,
    ProductFilter? filter,
  }) async {
    try {
      final key = _productPageKey(page: page, limit: limit, filter: filter);
      final cached = await _hiveStorage.read<String>(
        key,
        boxName: StorageConstants.productsBox,
      );
      if (cached == null) return null;

      final map = jsonDecode(cached) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(map['cachedAt'] as String);
      if (_isExpired(cachedAt)) {
        await _hiveStorage.delete(key, boxName: StorageConstants.productsBox);
        return null;
      }
      final itemsJson = map['items'] as List<dynamic>;
      final items = itemsJson
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return PaginatedCacheResponse<ProductModel>(
        items: items,
        page: page,
        limit: limit,
        cachedAt: cachedAt,
        totalCount: map['totalCount'] as int?,
        hasMore: map['hasMore'] as bool? ?? false,
      );
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getCachedProducts',
        'Failed to get cached products',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> cacheProduct(ProductModel product) async {
    try {
      await _hiveStorage.write(
        _productKey(product.id),
        jsonEncode(product.toJson()),
        boxName: StorageConstants.productsBox,
      );
    } catch (e, stackTrace) {
      _logAndRethrow('cacheProduct', 'Failed to cache product', e, stackTrace);
    }
  }

  @override
  Future<ProductModel?> getCachedProduct(String productId) async {
    try {
      final raw = await _hiveStorage.read<String>(
        _productKey(productId),
        boxName: StorageConstants.productsBox,
      );
      if (raw == null) return null;
      return ProductModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getCachedProduct',
        'Failed to get cached product',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> cacheMultipleProducts(List<ProductModel> products) async {
    try {
      await Future.wait(products.map(cacheProduct));
    } catch (e, stackTrace) {
      _logAndRethrow(
        'cacheMultipleProducts',
        'Failed to cache multiple products',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<List<ProductModel>> getCachedProductsByIds(
    List<String> productIds,
  ) async {
    try {
      final results = <ProductModel>[];
      for (final id in productIds) {
        final result = await getCachedProduct(id);
        if (result != null) {
          results.add(result);
        }
      }
      return results;
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getCachedProductsByIds',
        'Failed to get cached products by ids',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> cacheCategories(List<ProductCategoryModel> categories) async {
    try {
      final payload = categories.map((e) => e.toJson()).toList();
      await _hiveStorage.write(
        _categoriesKey(),
        jsonEncode({
          'categories': payload,
          'cachedAt': DateTime.now().toIso8601String(),
        }),
        boxName: StorageConstants.productsBox,
      );
    } catch (e, stackTrace) {
      _logAndRethrow(
        'cacheCategories',
        'Failed to cache categories',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<List<ProductCategoryModel>> getCachedCategories() async {
    try {
      final raw = await _hiveStorage.read<String>(
        _categoriesKey(),
        boxName: StorageConstants.productsBox,
      );
      if (raw == null) return [];

      final map = jsonDecode(raw) as Map<String, dynamic>;
      final cachedAt = DateTime.tryParse(map['cachedAt'] as String? ?? '');
      if (cachedAt != null && _isExpired(cachedAt)) {
        await _hiveStorage.delete(
          _categoriesKey(),
          boxName: StorageConstants.productsBox,
        );
        return [];
      }
      final list = map['categories'] as List<dynamic>? ?? [];
      return list
          .map((e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getCachedCategories',
        'Failed to get cached categories',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<ProductCategoryModel?> getCachedCategory(String categoryId) async {
    try {
      final categories = await getCachedCategories();
      //*** What is “closure context”?
      // The type information Dart infers for that function from its surrounding
      // call site. So the code that calls firstWhere must expect a ProductCategoryModel.
      // for .firstWhere on List<ProductCategoryModel> must return a ProductCategoryModel.
      // This is why we can't use .firstWhere here. because it returns a ProductCategoryModel?
      // orElse: () => null, is not a ProductCategoryModel.
      // ProductCagtegoryModel firstWhere(
      //     bool Function(ProductCategoryModel element) test, 
      //     { ProductCategoryModel Function()? orElse, }
      // )
      // return categories
      //     .firstWhere(    
      //       (category) => category.id == categoryId,
      //       orElse: () => null,
      //     );
     
      for (final category in categories) {
        if (category.id == categoryId) return category;
      }   
      return null;
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getCachedCategory',
        'Failed to get cached category',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> addToCachedProductReviews({
    required String productId,
    required ProductReviewModel review,
    required int page,
    required int limit,
  }) async {
    try {
      final reviews = await getCachedProductReviews(
        productId: productId, page: page, limit: limit
        );
      reviews.insert(0, review);
      if (reviews.length > limit) {
        reviews.removeRange(limit, reviews.length);
      }
      await cacheProductReviews(
        productId: productId,
        reviews: reviews,
        page: page,
        limit: limit,
      );
      // Page 2+ is stale after insert — delete those keys
      await _invalidateCachedProductReviews(
        productId: productId, exceptPage: page, limit: limit);
      // optional: only cache the new review on page 1 after next fetch
    } catch (e, stackTrace) {
      _logAndRethrow('addToCachedProductReviews', 'Failed to add review to cached product reviews', e, stackTrace);
    }
  }

  /// Deletes cached review pages for [productId] except the page/limit bucket
/// that was just updated (page 2+ becomes stale after inserting on page 1).
Future<void> _invalidateCachedProductReviews({
  required String productId,
  required int exceptPage,
  required int limit,
}) async {
  final prefix = _reviewsPrefix(productId);
  final keepKey = _reviewsKey(
    productId: productId,
    page: exceptPage,
    limit: limit,
  );

  final all = await _hiveStorage.getAll(
    boxName: StorageConstants.productsBox,
  );

  for (final key in all.keys) {
    if (!key.startsWith(prefix)) continue;
    if (key == keepKey) continue;
    await _hiveStorage.delete(
      key,
      boxName: StorageConstants.productsBox,
    );
  }
}

  @override
  Future<void> cacheProductReviews({
    required String productId,
    required List<ProductReviewModel> reviews,
    required int page,
    required int limit,
  }) async {
    try {
      final key = _reviewsKey(productId: productId, page: page, limit: limit);
      final payload = {
        'reviews': reviews.map((e) => e.toJson()).toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };
      final json = jsonEncode(payload);
      await _hiveStorage.write(
        key,
        json,
        boxName: StorageConstants.productsBox,
      );
    } catch (e, stackTrace) {
      _logAndRethrow('cacheReviews', 'Failed to cache reviews', e, stackTrace);
    }
  }

  @override
  Future<List<ProductReviewModel>> getCachedProductReviews(
    {required String productId, required int page, required int limit}) async {
    try {
      final key = _reviewsKey(productId: productId, page: page, limit: limit);

      final cached = await _hiveStorage.read<String>(
        key,
        boxName: StorageConstants.productsBox,
      );
      if (cached == null) return [];
      final map = jsonDecode(cached) as Map<String, dynamic>;
      final cachedAt = DateTime.parse(map['cachedAt'] as String);
      if (_isExpired(cachedAt)) {
        await _hiveStorage.delete(key, boxName: StorageConstants.productsBox);
        return [];
      }
      final reviews = map['reviews'] as List<dynamic>;
      return reviews.map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getCachedReviews',
        'Failed to get cached reviews',
        e,
        stackTrace,
      );
    }
  }
  
  @override
  Future<List<ProductModel>> searchCachedProducts(String query) async {
    try {
      final normalizedQuery = query.trim().toLowerCase();
      if (normalizedQuery.isEmpty) return [];

      final all = await _loadAllCachedProducts();
      return all.where((product) {
        return product.name.toLowerCase().contains(normalizedQuery) ||
            product.description.toLowerCase().contains(normalizedQuery);
      }).toList();
    } catch (e, stackTrace) {
      _logAndRethrow(
        'searchCachedProducts',
        'Failed to search cached products',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<List<ProductModel>> filterCachedProducts(ProductFilter filter) async  {
    try {
      final all = await _loadAllCachedProducts();
      return all.where(
        (product) {
          if (filter.categories.isNotEmpty) {
            final hasCategory = product.categories.any(
              (element) => filter.categories.contains(element),
              );
              if (!hasCategory) return false;
          }
          if (filter.minPrice != null && product.price < filter.minPrice!) {
            return false;
          }
          if (filter.maxPrice != null && product.price > filter.maxPrice!) {
            return false;
          }
          if (filter.inStockOnly && !product.inStock) {
            return false;
          }
          if (filter.searchQuery != null &&
            filter.searchQuery!.isNotEmpty &&
           !product.name
             .toLowerCase()
             .contains(filter.searchQuery!.toLowerCase())) {
            return false;
           }
          return true;
        }
      ).toList();
    } catch (e, stackTrace) {
      _logAndRethrow(
        'filterCachedProducts',
        'Failed to filter cached products',
        e,
        stackTrace,
      );
    }
  }

   @override
  Future<void> cacheRecentlyViewed(List<ProductModel> products) async {
    try {
      final key = _recentlyViewedKey();
      final payload = {
        'products': products.map((e) => e.toJson()).toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };
      final json = jsonEncode(payload);
      await _hiveStorage.write(key, json, boxName: StorageConstants.productsBox);
    } catch (e, stackTrace) {
      _logAndRethrow('cacheRecentlyViewed', 'Failed to cache recently viewed products', e, stackTrace);
    }
   
  }

  @override
  Future<void> addToCachedRecentlyViewed(ProductModel product) async {
    try {
      await cacheProduct(product);
      final ids = await _readIdList(
        key: _recentlyViewedKey(),
      );
      ids
      ..remove(product.id)
      ..insert(0, product.id);

      final trimmed = ids
          .take(StorageConstants.productsMaxRecentlyViewedItems)
          .toList();
      await _writeIdList(
        key: _recentlyViewedKey(),
        ids: trimmed,
      );
    } catch (e, stackTrace) {
      _logAndRethrow(
        'addToRecentlyViewed',
        'Failed to add product to recently viewed',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<List<ProductModel>> getCachedRecentlyViewed() async {
    try {
      final ids = await _readIdList(
        key: _recentlyViewedKey(),
      );
      return getCachedProductsByIds(ids);
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getRecentlyViewed',
        'Failed to get recently viewed products',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> clearCachedRecentlyViewed() async {
    try {
      await _hiveStorage.delete(
        _recentlyViewedKey(),
        boxName: StorageConstants.productsBox,
      );
    } catch (e, stackTrace) {
      _logAndRethrow(
        'clearRecentlyViewed',
        'Failed to clear recently viewed products',
        e,
        stackTrace,
      );
    }
  }

 @override
  Future<void> cacheWishlist(List<ProductModel> products) async {
    try {
      final key = _wishlistKey();
      final payload = {
        'products': products.map((e) => e.toJson()).toList(),
        'cachedAt': DateTime.now().toIso8601String(),
      };
      final json = jsonEncode(payload);
      await _hiveStorage.write(key, json, boxName: StorageConstants.productsBox);
    } catch (e, stackTrace) {
      _logAndRethrow('cacheWishlist', 'Failed to cache wishlist', e, stackTrace);
    }
  }

  @override
  Future<void> addToCachedWishlist(String productId) async {
    try {
      final ids = await _readIdList(
        key: _wishlistKey(),
      );
      if (!ids.contains(productId)) {
        ids.add(productId);
        await _writeIdList(
          key: _wishlistKey(),
          ids: ids,
        );
      }
    } catch (e, stackTrace) {
      _logAndRethrow(
        'addToWishlist',
        'Failed to add product to wishlist',
        e,
        stackTrace,
      );
    }
  }
  
  /// *** IMPORTANT: toggleCachedWishlist is not implemented because
  /// it can revert the local change if the remote fails
  // @override
  // Future<void> toggleCachedWishlist(String productId) async {
  //   try {
  //     final ids = await _readIdList(
  //       key: _wishlistKey(),
  //     );
  //     if (ids.contains(productId)) {
  //       await removeFromCachedWishlist(productId);
  //     } else {
  //       await addToCachedWishlist(productId);
  //     }
  //   } catch (e, stackTrace) {
  //     _logAndRethrow(
  //       'toggleWishlist',
  //       'Failed to toggle wishlist',
  //       e,
  //       stackTrace,
  //     );
  //   }
  // } 

  @override
  Future<void> removeFromCachedWishlist(String productId) async {
    try {
      final ids = await _readIdList(
        key: _wishlistKey(),
      );
      ids.remove(productId);
      await _writeIdList(
        key: _wishlistKey(),
        ids: ids,
      );
    } catch (e, stackTrace) {
      _logAndRethrow(
        'removeFromWishlist',
        'Failed to remove product from wishlist',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<bool> isInCachedWishlist(String productId) async {
    try {
      final ids = await _readIdList(
        key: _wishlistKey(),
      );
      return ids.contains(productId);
    } catch (e, stackTrace) {
      _logAndRethrow(
        'isInWishlist',
        'Failed to check if product is in wishlist',
        e,
        stackTrace,
      );
    }
  }

 
  @override
  Future<List<ProductModel>> getCachedWishlist() async {
    try {
      final ids = await _readIdList(
        key: _wishlistKey(),
      );
      return getCachedProductsByIds(ids);
    } catch (e, stackTrace) {
      _logAndRethrow(
        'getWishlist',
        'Failed to get wishlist products',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> clearCachedWishlist() async {
    try {
      await _hiveStorage.delete(
        _wishlistKey(),
        boxName: StorageConstants.productsBox,
      );
    } catch (e, stackTrace) {
      _logAndRethrow(
        'clearWishlist',
        'Failed to clear wishlist',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _hiveStorage.clear(boxName: StorageConstants.productsBox);
      logger.i('[ProductLocalDataSourceImpl] Cleared cache');
    } catch (e, stackTrace) {
      _logAndRethrow('clearCache', 'Failed to clear cache', e, stackTrace);
    }
  }

  @override
  Future<void> clearExpiredCache() async {
    try {
      final all = await _hiveStorage.getAll(
        boxName: StorageConstants.productsBox,
      );
      for (final entry in all.entries) {
        final value = entry.value;
        if (value is! String) continue;
        try {
          final map = jsonDecode(value) as Map<String, dynamic>;
          if (map.containsKey('cachedAt')) {
            final cachedAt = DateTime.parse(map['cachedAt'] as String? ?? '');
            if (_isExpired(cachedAt)) {
              await _hiveStorage.delete(
                entry.key,
                boxName: StorageConstants.productsBox,
              );
            }
          }
        } catch (e, stackTrace) {
          // skip this entry and continue with the next one
          logger.e(
            '[ProductLocalDataSourceImpl] Failed to decode cached value',
            error: e,
            stackTrace: stackTrace,
          );
        }
      }
    } catch (e, stackTrace) {
      _logAndRethrow(
        'clearExpiredCache',
        'Failed to clear expired cache',
        e,
        stackTrace,
      );
    }
  }

  @override
  Future<int> getCacheSize() async {
    try {
      final all = await _hiveStorage.getAll(
        boxName: StorageConstants.productsBox,
      );
      int totalSize = 0;
      for (final entry in all.entries) {
        final value = entry.value;
        if (value is! String) continue;
        totalSize += value.length;
      }
      return totalSize;
    } catch (e, stackTrace) {
      _logAndRethrow('getCacheSize', 'Failed to get cache size', e, stackTrace);
    }
  }

  bool _isExpired(DateTime cachedAt) =>
      DateTime.now().difference(cachedAt) > StorageConstants.defaultTtl;

  String _productKey(String productId) => 
  '${StorageConstants.productsBoxProductPrefix}$productId';
  
  String _productPageKey({
    required int page,
    required int limit,
    ProductFilter? filter,
  }) => 
  '${StorageConstants.productsBoxProductsPrefix}'
  '${StorageConstants.productsBoxPagePrefix}$page:'
  '${StorageConstants.productsBoxLimitPrefix}$limit:'
  '${StorageConstants.productsBoxFilterPrefix}${_filterCacheKey(filter)}';
  
  String _reviewsKey({
    required String productId,
    required int page,
    required int limit,
  }) => 
  '${StorageConstants.productsBoxProductPrefix}'
  '${StorageConstants.productsBoxReviewsPrefix}'
  '$productId:'
  '${StorageConstants.productsBoxPagePrefix}$page:'
  '${StorageConstants.productsBoxLimitPrefix}$limit:';

  String _reviewsPrefix(String productId) => 
  '${StorageConstants.productsBoxProductPrefix}'
  '${StorageConstants.productsBoxReviewsPrefix}'
  '$productId:';

   String _wishlistKey() => 
   '${StorageConstants.productsBoxProductsPrefix}'
   '${StorageConstants.productsBoxWishlistPrefix}';


  String _categoriesKey() => 
  '${StorageConstants.productsBoxProductsPrefix}'
  '${StorageConstants.productsBoxCategoriesPrefix}';
  String _recentlyViewedKey() => 
  '${StorageConstants.productsBoxProductsPrefix}'
  '${StorageConstants.productsBoxRecentlyViewedPrefix}';
  String _relatedProductsKey(String productId) => 
  '${StorageConstants.productsBoxProductsPrefix}'
  '${StorageConstants.productsBoxRelatedProductsPrefix}'
  '$productId:';
  String _featuredProductsKey(int limit) => 
  '${StorageConstants.productsBoxProductsPrefix}'
  '${StorageConstants.productsBoxFeaturedProductsPrefix}'
  '$limit:';


  bool _isSingleProductKey(String key) {
    if (!key.startsWith(StorageConstants.productsBoxProductPrefix)) {
      return false;
    }
    // check if the key is a reviews key
    final reviewsPrefix = 
    '${StorageConstants.productsBoxProductPrefix}'
    '${StorageConstants.productsBoxReviewsPrefix}';
    return !key.startsWith(reviewsPrefix);
  }

  String _filterCacheKey(ProductFilter? filter) {
    if (filter == null) return 'none';
    return [
      filter.categories.join('|'),
      filter.minPrice?.toString() ?? '',
      filter.maxPrice?.toString() ?? '',
      // prefer if-else over ternary operator
      // filter.inStockOnly ? '1' : '0',
      if (filter.inStockOnly) '1' else '0',
      filter.minRating?.toString() ?? '',
      filter.sortBy ?? '',
      filter.searchQuery ?? '',
    ].join(':');
  }

  // so the execution Never continues on the next line. (throw, exit(), 
  //infinite loop, etc.)
  Never _logAndRethrow(
    String methodName,
    String errorMessage,
    Object? e,
    StackTrace stackTrace,
  ) {
    logger.e(
      '[ProductLocalDataSourceImpl] $methodName failed: $errorMessage',
      error: e,
      stackTrace: stackTrace,
    );
    throw CacheException(message: errorMessage, stackTrace: stackTrace);
  }

  Future<List<String>> _readIdList({required String key}) async {
    final ids = await _hiveStorage.read<List<String>>(
      key,
      boxName: StorageConstants.productsBox,
    );
    return ids ?? [];
  }

  Future<void> _writeIdList({
    required String key,
    required List<String> ids,
  }) async {
    await _hiveStorage.write(key, ids, boxName: StorageConstants.productsBox);
  }

  Future<List<ProductModel>> _loadAllCachedProducts() async {
    final all = await _hiveStorage.getAll(
      boxName: StorageConstants.productsBox,
    );
    final products = <ProductModel>[];

    for (final entry in all.entries) {
      if (!_isSingleProductKey(entry.key)) continue;
      final value = entry.value;
      if (value is! String) continue;
      try {
        products.add(
          ProductModel.fromJson(jsonDecode(value) as Map<String, dynamic>),
        );
      } catch (e, stackTrace) {
        // skip this entry and continue with the next one
        logger.e(
          '[ProductLocalDataSourceImpl] Failed to decode cached product',
          error: e,
          stackTrace: stackTrace,
        );
      }
    }
    return products;
  }
  
}
