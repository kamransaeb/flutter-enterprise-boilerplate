// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductFilterModel _$ProductFilterModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ProductFilterModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'categories',
        'min_price',
        'max_price',
        'in_stock_only',
        'min_rating',
        'sort_by',
        'search_query',
        'page',
        'limit',
      ],
    );
    final val = _ProductFilterModel(
      categories: $checkedConvert(
        'categories',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
      minPrice: $checkedConvert('min_price', (v) => (v as num?)?.toDouble()),
      maxPrice: $checkedConvert('max_price', (v) => (v as num?)?.toDouble()),
      inStockOnly: $checkedConvert('in_stock_only', (v) => v as bool? ?? false),
      minRating: $checkedConvert('min_rating', (v) => (v as num?)?.toDouble()),
      sortBy: $checkedConvert('sort_by', (v) => v as String?),
      searchQuery: $checkedConvert('search_query', (v) => v as String?),
      page: $checkedConvert('page', (v) => (v as num?)?.toInt() ?? 1),
      limit: $checkedConvert('limit', (v) => (v as num?)?.toInt() ?? 20),
    );
    return val;
  },
  fieldKeyMap: const {
    'minPrice': 'min_price',
    'maxPrice': 'max_price',
    'inStockOnly': 'in_stock_only',
    'minRating': 'min_rating',
    'sortBy': 'sort_by',
    'searchQuery': 'search_query',
  },
);

Map<String, dynamic> _$ProductFilterModelToJson(_ProductFilterModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      'in_stock_only': instance.inStockOnly,
      'min_rating': instance.minRating,
      'sort_by': instance.sortBy,
      'search_query': instance.searchQuery,
      'page': instance.page,
      'limit': instance.limit,
    };
