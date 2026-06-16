import 'dart:core';

import 'package:flutter_enterprise_boilerplate/features/products/data/datasources/product_remote_data_source.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_category_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/api_client.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/api_response.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/response_converter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<ApiResponse<List<ProductModel>>> getProducts({
    required int page,
    required int limit,
    String? category,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    bool? inStockOnly,
    double? minRating,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final httpResponse = await _apiClient.getProducts(
        page: page,
        limit: limit,
        category: category,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
        inStockOnly: inStockOnly,
        minRating: minRating,
        sortOrder: sortOrder,
        searchQuery: searchQuery,
      );

      final apiResponse = ResponseConverter.toApiResponse<List<ProductModel>>(
        httpResponse.response,
        (json) => _parseProductList(json),
      );

      if (apiResponse.isSuccess) return apiResponse;

      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getProducts failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<ProductModel>> getProductById({
    required String productId,
  }) async {
    try {
      final httpResponse = await _apiClient.getProductById(
        productId: productId,
      );
      final apiResponse = ResponseConverter.toApiResponse<ProductModel>(
        httpResponse.response,
        (json) => ProductModel.fromJson(json as Map<String, dynamic>),
      );
      if (apiResponse.isSuccess) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getProductById failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> getFeaturedProducts() async {
    try {
      final httpResponse = await _apiClient.getFeaturedProducts();
      final apiResponse = ResponseConverter.toApiResponse<List<ProductModel>>(
        httpResponse.response,
        (json) => _parseProductList(json),
      );
      if (apiResponse.isSuccess) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getFeaturedProducts failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  Future<ApiResponse<List<ProductCategoryModel>>> getCategories({
    String? parentId,
  }) async {
    try {
      final httpResponse = await _apiClient.getCategories(parentId: parentId);
      final apiResponse =
          ResponseConverter.toApiResponse<List<ProductCategoryModel>>(
            httpResponse.response,
            (json) => _parseCategoryList(json),
          );
      if (apiResponse.isSuccess) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getCategories failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  Future<ApiResponse<List<ProductReviewModel>>> getProductReviews({
    required String productId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final httpResponse = await _apiClient.getProductReviews(
        productId: productId,
        page: page,
        limit: limit,
      );
      final apiResponse =
          ResponseConverter.toApiResponse<List<ProductReviewModel>>(
            httpResponse.response,
            (json) => _parseProductReviewList(json),
          );
      if (apiResponse.isSuccess && apiResponse.hasData) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getProductReviews failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  List<ProductReviewModel> _parseProductReviewList(dynamic json) {
    if (json is List) {
      return json
          .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map<String, dynamic>) {
      final data = json['data'] ?? json['items'] ?? json['reviews'];
      if (data is List) {
        return data
            .map((e) => ProductReviewModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  Future<ApiResponse<ProductReviewModel>> addProductReview({
    required String productId,
    required ProductReviewModel productReviewModel,
  }) async {
    try {
      final httpResponse = await _apiClient.addProductReview(
        productId: productId,
        productReviewModel: productReviewModel,
      );
      final apiResponse = ResponseConverter.toApiResponse<ProductReviewModel>(
        httpResponse.response,
        (json) => ProductReviewModel.fromJson(json as Map<String, dynamic>),
      );
      if (apiResponse.isSuccess && apiResponse.hasData) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] addProductReview failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  Future<ApiResponse<void>> toggleFavorite({required String productId}) async {
    try {
      final wishlistResponse = await _apiClient.getWishlist();
      final wishList = _parseWishlistProducts(wishlistResponse.response.data);
      final isFavorite = wishList.contains(productId);

      final httpResponse = isFavorite
          ? await _apiClient.removeFromWishlist(productId)
          : await _apiClient.addToWishlist({'product_id': productId});

      final apiResponse = ResponseConverter.toApiResponse<void>(
        httpResponse.response,
        // (_) {},
        (json) => null,
      );
      if (apiResponse.isSuccess) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] toggleFavorite failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> getFavorites({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final httpResponse = await _apiClient.getWishlist();
      final apiResponse = ResponseConverter.toApiResponse<List<ProductModel>>(
        httpResponse.response,
        (json) => _parseWishlistProducts(json),
      );
      if (!apiResponse.isSuccess) {
        return ErrorApiResponse(
          statusCode: httpResponse.response.statusCode,
          error: ResponseConverter.toErrorResponse(httpResponse.response),
        );
      }
      final all = apiResponse.data ?? [];
      final start = (page - 1) * limit;
      if (start >= all.length) {
        return SuccessResponse.fromData(<ProductModel>[]);
      }
      //clamp is used to ensure that the end is not greater than the length of the list
      // 5.clamp(0, 10);    // → 5
      // (-3).clamp(0, 10); // → 0
      // (15).clamp(0, 10); // → 10
      final end = (start + limit).clamp(0, all.length);
      return SuccessResponse.fromData(all.sublist(start, end));
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getFavorites failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> searchProducts({
    required String query,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final httpResponse = await _apiClient.searchProducts(
        query: query,
        page: page,
        limit: limit,
      );
      final apiResponse = ResponseConverter.toApiResponse<List<ProductModel>>(
        httpResponse.response,
        (json) => _parseProductList(json),
      );
      if (apiResponse.isSuccess) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] searchProducts failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  @override
  Future<ApiResponse<List<ProductModel>>> getRelatedProducts({
    required String productId,
  }) async {
    try {
      final httpResponse = await _apiClient.getRelatedProducts(
        productId: productId,
      );
      final apiResponse = ResponseConverter.toApiResponse<List<ProductModel>>(
        httpResponse.response,
        (json) => _parseProductList(json),
      );
      if (apiResponse.isSuccess) return apiResponse;
      return ErrorApiResponse(
        statusCode: httpResponse.response.statusCode,
        error: ResponseConverter.toErrorResponse(httpResponse.response),
      );
    } catch (e, stackTrace) {
      logger.e(
        '[ProductRemoteDataSourceImpl] getRelatedProducts failed',
        error: e,
        stackTrace: stackTrace,
      );
      return ErrorApiResponse.fromException(e, stackTrace: stackTrace);
    }
  }

  // Implement other methods the same way (featured, categories, reviews, etc.)

  // ---------------------------------------------------------------------------
  // Parsers
  // ---------------------------------------------------------------------------

  List<ProductModel> _parseProductList(dynamic json) {
    if (json is List) {
      return json
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map<String, dynamic>) {
      final data = json['data'] ?? json['items'] ?? json['products'];
      if (data is List) {
        return data
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    }
    return [];
  }

  List<ProductCategoryModel> _parseCategoryList(dynamic json) {
    if (json is List) {
      return json
          .map((e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    if (json is Map<String, dynamic>) {
      final data = json['data'] ?? json['items'] ?? json['categories'];
      if (data is List) {
        return data
            .map(
              (e) => ProductCategoryModel.fromJson(e as Map<String, dynamic>),
            )
            .toList();
      }
    }
    return [];
  }

  List<ProductModel> _parseWishlistProducts(dynamic json) {
    if (json is! List) return [];
    return json
        .map((item) {
          if (item is! Map<String, dynamic>) return null;

          final productJson = item['product'] ?? item;
          if (productJson is! Map<String, dynamic>) return null;

          return ProductModel.fromJson(productJson);
        })
        .whereType<ProductModel>()
        .toList();
  }

  Set<String> _parseWithlistProductIds(dynamic json) {
    if (json is! List) return {};

    return json
        .map((item) {
          if (item is! Map<String, dynamic>) return null;

          if (item['product_id'] is String) return item['product_id'] as String;
          if (item['id'] is String) return item['id'] as String;

          final product = item['product'];
          if (product is Map<String, dynamic> && product['id'] is String) {
            return product['id'] as String;
          }
          return null;
          //keeps only elemeets that are actually a String, and drops everything else
        })
        .whereType<String>()
        .toSet();
  }
}
