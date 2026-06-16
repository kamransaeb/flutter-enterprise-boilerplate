// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ProductModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'id',
        'name',
        'description',
        'price',
        'image_url',
        'in_stock',
        'rating',
        'review_count',
        'categories',
        'attributes',
        'original_price',
        'brand',
        'sku',
        'stock_quantity',
        'created_at',
        'updated_at',
        'is_favorite',
        'is_featured',
      ],
    );
    final val = _ProductModel(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      description: $checkedConvert('description', (v) => v as String),
      price: $checkedConvert('price', (v) => (v as num).toDouble()),
      imageUrl: $checkedConvert('image_url', (v) => v as String),
      inStock: $checkedConvert('in_stock', (v) => v as bool? ?? false),
      rating: $checkedConvert('rating', (v) => (v as num?)?.toDouble() ?? 0.0),
      reviewCount: $checkedConvert(
        'review_count',
        (v) => (v as num?)?.toInt() ?? 0,
      ),
      categories: $checkedConvert(
        'categories',
        (v) =>
            (v as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      ),
      attributes: $checkedConvert(
        'attributes',
        (v) => v as Map<String, dynamic>? ?? const {},
      ),
      originalPrice: $checkedConvert(
        'original_price',
        (v) => (v as num?)?.toDouble(),
      ),
      brand: $checkedConvert('brand', (v) => v as String?),
      sku: $checkedConvert('sku', (v) => v as String?),
      stockQuantity: $checkedConvert(
        'stock_quantity',
        (v) => (v as num?)?.toInt(),
      ),
      createdAt: $checkedConvert(
        'created_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      updatedAt: $checkedConvert(
        'updated_at',
        (v) => v == null ? null : DateTime.parse(v as String),
      ),
      isFavorite: $checkedConvert('is_favorite', (v) => v as bool? ?? false),
      isFeatured: $checkedConvert('is_featured', (v) => v as bool? ?? false),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageUrl': 'image_url',
    'inStock': 'in_stock',
    'reviewCount': 'review_count',
    'originalPrice': 'original_price',
    'stockQuantity': 'stock_quantity',
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
    'isFavorite': 'is_favorite',
    'isFeatured': 'is_featured',
  },
);

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image_url': instance.imageUrl,
      'in_stock': instance.inStock,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'categories': instance.categories,
      'attributes': instance.attributes,
      'original_price': instance.originalPrice,
      'brand': instance.brand,
      'sku': instance.sku,
      'stock_quantity': instance.stockQuantity,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_favorite': instance.isFavorite,
      'is_featured': instance.isFeatured,
    };
