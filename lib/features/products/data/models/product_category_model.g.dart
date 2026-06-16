// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductCategoryModel _$ProductCategoryModelFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_ProductCategoryModel',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'id',
        'name',
        'description',
        'image_url',
        'parent_id',
        'product_count',
        'children',
      ],
    );
    final val = _ProductCategoryModel(
      id: $checkedConvert('id', (v) => v as String),
      name: $checkedConvert('name', (v) => v as String),
      description: $checkedConvert('description', (v) => v as String?),
      imageUrl: $checkedConvert('image_url', (v) => v as String?),
      parentId: $checkedConvert('parent_id', (v) => v as String?),
      productCount: $checkedConvert(
        'product_count',
        (v) => (v as num?)?.toInt() ?? 0,
      ),
      children: $checkedConvert(
        'children',
        (v) =>
            (v as List<dynamic>?)
                ?.map(
                  (e) =>
                      ProductCategoryModel.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            const [],
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'imageUrl': 'image_url',
    'parentId': 'parent_id',
    'productCount': 'product_count',
  },
);

Map<String, dynamic> _$ProductCategoryModelToJson(
  _ProductCategoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'image_url': instance.imageUrl,
  'parent_id': instance.parentId,
  'product_count': instance.productCount,
  'children': instance.children.map((e) => e.toJson()).toList(),
};
